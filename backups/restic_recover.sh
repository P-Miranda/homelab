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

GOMAXPROCS=4

RESTIC_RECOVER_PATH=/media/NAS-home/rclone-recover/restic-backup
RECOVER_TARGET=/media/NAS-home/restic-restore

mkdir -p $RECOVER_TARGET

# backup
${RESTIC_CMD} restore latest \
    -p $RESTIC_PASSWORD_FILE \
    --repo $RESTIC_RECOVER_PATH --verbose \
    --target $RECOVER_TARGET
