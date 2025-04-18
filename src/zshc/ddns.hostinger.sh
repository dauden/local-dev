#!/usr/bin/env bash
# Update DNS for your domain from hostinger
declare ZONE="storage"
declare API_KEY="xxxx"
declare DOMAIN="codingland.com"
declare HOST="https://developers.hostinger.com"
declare API_VERSION="/api/dns/v1/zones"
declare LAST_IP_FILE="/tmp/dns_last_ip_$DOMAIN"

if ! hash curl 2>/dev/null; then
	echo "ERROR: cURL is missing."
	exit 1
fi

RECORDS=
RECORD=
PAYLOAD_RECORD=""
LAST_IP=
CURRENT_IP=
UPDATE_RESULT=

findRecordsByName() {
  local TARGET_NAME="$1"
  # Filter JSON using jq
  RECORD=$(echo "$RECORDS" | jq --arg name "$TARGET_NAME" '.[] | select(.name == $name)')
  if [ "$RECORD" = "" ]; then
      write_msg "Error: Record ${TARGET_NAME} not found."
      exit 2
  fi
}

getRecords() {
  RECORDS=$(curl "${HOST}${API_VERSION}/${DOMAIN}" \
    --silent \
    --header "Authorization: Bearer ${API_KEY}")
  if [ "$RECORDS" = "" ]; then
      write_msg "Error: Unable to retrieve current records."
      exit 2
  fi
}

getCurrentIp() {
  CURRENT_IP=$(curl --silent ipinfo.io/ip)
}

replaceIP() {
  local NEW_IP="$1"
  PAYLOAD_RECORD=$(echo "$RECORD" | jq --arg new_content "$NEW_IP" '
    .records |= map(.content = $new_content)
  ')
}

updateRecord() {
  UPDATE_RESULT=$(curl --silent "${HOST}${API_VERSION}/${DOMAIN}" \
    --request PUT \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer ${API_KEY}" \
    --data "{\"overwrite\": true, \"zone\": [
            $PAYLOAD_RECORD
    ]}" )
  MESSAGE=$(echo "$UPDATE_RESULT" | jq -r '.message')
  echo "$MESSAGE"
  if [ "$MESSAGE" == "Request accepted" ]; then
      echo "$CURRENT_IP" > $LAST_IP_FILE
      exit 0
  fi
}

getLastIp() {
  LAST_IP=$(echo "$RECORD" | jq -r '.records[].content')
  if [ "$LAST_IP" = "" ]; then
      write_msg "Error: Current IP not found from ${ZONE} zone."
      exit 2
  fi
}


# Get last known IP address that was stored locally
if [ -f "$LAST_IP_FILE" ]; then
	LAST_IP=`head -n 1 $LAST_IP_FILE`
fi
echo "Last IP is: $LAST_IP"

getCurrentIp
echo "Current public IP detected is: $CURRENT_IP"

if [ "$LAST_IP" != "$CURRENT_IP" ];
then
  getRecords
  findRecordsByName $ZONE
  if [ "$LAST_IP" == "" ]; then
      getLastIp
  fi
  if [ "$LAST_IP" == "$CURRENT_IP" ];
  then
    echo "Not updating DNS host ${HOST} for Zone ${ZONE} of ${DOMAIN} domain: IP address unchanged"
    exit 0;
  fi
  replaceIP $CURRENT_IP
  updateRecord
else
  echo "Not updating DNS host ${HOST} for Zone ${ZONE} of ${DOMAIN} domain: IP address unchanged"
  exit 0;
fi
