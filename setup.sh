#!/bin/bash

declare ROOT_DIR=~/datalocal
declare -a OPTIONS=( "mysql" "postgres" "redis" "elasticsearch" "kibana" "adminer" "phpmyadmin" "pgadmin4" )
declare -a SELECTED

function createDir() {
        rm -rf $ROOT_DIR 
        mkdir $ROOT_DIR
        
        for j in "${OPTIONS[@]}"; do
                mkdir "${ROOT_DIR}/${j}"
        done
}

function selectedOptions() {
        for i in "${OPTIONS[@]}"; do
                echo "Do you want to deploy ${i} in you local? type 'y' or 'n' default is yes: \n"
                read -r -sn1 t
                if [[ $t == y || $t == "" ]]; then
                        SELECTED+=($i)
                fi
        done
}

createDir
