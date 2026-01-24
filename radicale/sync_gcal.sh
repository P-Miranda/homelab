#!/usr/bin/env bash

SCRIPT_PATH=$(dirname -- "$0")
ENV_FILE=$SCRIPT_PATH/.env

if [ -f $ENV_FILE ]
then
  source $ENV_FILE
else
  echo "No .env file found."
  exit 1
fi

RADICALE_PATH=./data/collection-root/$RADICALE_USER/$RADICALE_CAL

mkdir -p $RADICALE_PATH
curl -s $GCAL_URL > $RADICALE_PATH/$GCAL_NAME
