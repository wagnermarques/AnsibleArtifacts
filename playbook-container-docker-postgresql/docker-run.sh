#!/bin/bash
#https://hub.docker.com/_/postgres/
CONTAINER_NAME=$1
PGPORT_inContainer=$2
PGPORT_inHost=$3
PGDATA_Volume=$4
PGDATA=$5
POSTGRES_PASSWORD=$6
POSTGRES_USER=$7
POSTGRES_DB=$8
SqlScriptsDir_Volume=$9
SqlScriptsDir="/scripts"
IMG_NAME="postgres:13.1-alpine"

docker run --name $CONTAINER_NAME \
       -h $CONTAINER_NAME \
       -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
       -e POSTGRES_USER=$POSTGRES_USER  \
       -e PGDATA=$PGDATA \
       -e POSTGRES_DB=$POSTGRES_DB \
       -p $PGPORT_inHost:$PGPORT_inContainer \
       -v $PGDATA_Volume:$PGDATA \
       -v $SqlScriptsDir_Volume:$SqlScriptsDir \
       -d $IMG_NAME

#       -v $(pwd)/sqlscripts:/sqlscripts \
#       -v $DATADIR:/var/lib/postgresql/data \

#	--net fzl_network_bridge \
#	--ip $CONTAINER_IP  \
