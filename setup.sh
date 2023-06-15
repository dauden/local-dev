#!/bin/bash

export STACK_NAME=LOCAL_DEV

export ROOT_DIR=~/datalocal
declare -a OPTIONS=("mysql" "postgres" "redis" "elasticsearch" "kibana" "phpmyadmin" "pgadmin4" "gitlab-runner" "elasticmq")
declare -a SELECTED

function createDir() {
	# rm -rf $ROOT_DIR
	# mkdir $ROOT_DIR

	if [ -d "$ROOT_DIR" ]; then
		echo "Warning: '$ROOT_DIR' found ..."
	else
		mkdir $ROOT_DIR
	fi
	for j in "${SELECTED[@]}"; do
		if [ -d "${ROOT_DIR}/${j}" ]; then
			echo "Warning: '${ROOT_DIR}/${j}' found ..."
		else
			mkdir "${ROOT_DIR}/${j}"
			if [[ $j == elasticsearch ]]; then
				touch "${ROOT_DIR}/${j}/elasticsearch.env"
			fi

			if [[ $j == gitlab-runner ]]; then
				touch "${ROOT_DIR}/${j}/config"
				touch "${ROOT_DIR}/${j}/run"
			fi

			if [[ $j == elasticmq ]]; then
				touch "${ROOT_DIR}/${j}/elasticmq.conf"
			fi
		fi

		cat ./src/${j}.yml >>local-stack.yml
	done
}

function exportValue() {
	case $i in
	"mysql")
		export MYSQL_ROOT_PASSWORD=admin

		printf "Do you want to create mysql password? default is 'admin'"
		read -r mysql_password
		if [[ ! $mysql_password == "" ]]; then
			export MYSQL_ROOT_PASSWORD=$mysql_password
		fi
		;;
	"postgres")
		export POSTGRES_USERNAME=postgres
		export POSTGRES_PASSWORD=password
		printf "Do you want to create postgres user? default is 'postgres'"
		read -r postgres_username
		if [[ ! $postgres_username == "" ]]; then
			export POSTGRES_USERNAME=$postgres_username
		fi
		printf "Do you want to create postgres password? default is 'password'"
		read -r postgres_password
		if [[ ! $postgres_password == "" ]]; then
			export POSTGRES_PASSWORD=$postgres_password
		fi
		;;
	"pgadmin4")
		export PGADMIN_DEFAULT_EMAIL=dev@codingland.com
		export PGADMIN_DEFAULT_PASSWORD=password
		printf "Do you want to set pgadmin4 email? default is 'dev@codingland.com'"
		read -r pgadmin4_email
		if [[ ! $pgadmin4_email == "" ]]; then
			export PGADMIN_DEFAULT_EMAIL=$pgadmin4_email
		fi
		printf "Do you want to create pgadmin4 password? default is 'password'"
		read -r pgadmin4s_password
		if [[ ! $pgadmin4s_password == "" ]]; then
			export PGADMIN_DEFAULT_PASSWORD=$pgadmin4s_password
		fi
		;;
	esac
}

function selectedOptions() {
	for i in "${OPTIONS[@]}"; do
		printf "Do you want to deploy ${i} in you local? type 'y' or 'n' default is yes: \n"
		read -r -sn1 t
		if [[ $t == y || $t == "" ]]; then
			SELECTED+=($i)
			exportValue "${i}"
		fi
	done
}

printf "Where do you want to store datalocal? default '~/datalocal' \n"

read -r datalocal
if [[ ! $datalocal == "" ]]; then
	export ROOT_DIR=$datalocal
fi

rm -rf local-stack.yml

cat ./src/local-stack.yml >>local-stack.yml

selectedOptions

createDir

cat ./src/network.yml >>local-stack.yml

printf "Give local stack name? Defaul is 'LOCAL_DEV' \n"

read -r stack_name
if [[ ! $stack_name == "" ]]; then
	export STACK_NAME=$stack_name
fi

docker stack deploy -c ./local-stack.yml ${STACK_NAME}