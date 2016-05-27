#!/bin/bash

DB_CONTAINER_NAME=familyalbum_db
DB_IMAGE_NAME=familyalbum_db
FRONTEND_CONT_NAME=familyalbum_app
FRONTEND_IMAGE_NAME=familyalbum_app
LOCAL_DATA=$HOME/data


# launch database container
DB_CONT_NAME=`docker ps -a | grep $DB_IMAGE_NAME | awk '{print $NF}'| tail -n 1`
if [[ -z "$DB_CONT_NAME" ]]
# The container has not yet been initialized
then
  docker run --name=$DB_CONTAINER_NAME $DB_IMAGE_NAME &
  sleep 90
else
  docker start $DB_CONT_NAME
fi

# launch frontend container
APP_CONT_NAME=`docker ps -a | grep $FRONTEND_IMAGE_NAME | awk '{print $NF}'| tail -n 1`
if [[ -z "$APP_CONT_NAME" ]]
# The container has not yet been initialized
then
docker run -p 80:80 -p 2222:22 -p 443:443 --name=$FRONTEND_CONT_NAME --link=$DB_CONTAINER_NAME:$DB_CONTAINER_NAME \
     -v $LOCAL_DATA:/data:Z $FRONTEND_IMAGE_NAME &
else
  docker start $FRONTEND_CONT_NAME
fi

