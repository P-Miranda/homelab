#!/usr/bin/env bash

OUT_PATH=$(dirname -- "$0")
ENV_FILE=$OUT_PATH/.env
LOG_FILE=$OUT_PATH/duck.log

if [ -f $ENV_FILE ]
then
  source $ENV_FILE
else
  DOMAIN=DOMAIN
  TOKEN=TOKEN
fi

echo url="https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&ip=" | curl -k -o $LOG_FILE -K -
