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

GOMAXPROCS=1

# backup
${RESTIC_CMD} backup \
    -p $RESTIC_PASSWORD_FILE \
    --repo $RESTIC_REPO_PATH --verbose \
    --compression $RESTIC_COMPRESSION \
    --exclude-file $RESTIC_EXCLUDE_FILE \
    --files-from $RESTIC_INCLUDE_FILE > $RESTIC_LOG 2>&1

# forget + prune
${RESTIC_CMD} forget \
    -p $RESTIC_PASSWORD_FILE \
    --repo $RESTIC_REPO_PATH --verbose \
    --keep-daily 3 \
    --keep-weekly 2 \
    --keep-monthly 1 \
    --prune >> $RESTIC_LOG 2>&1

# check
${RESTIC_CMD} check \
    -p $RESTIC_PASSWORD_FILE \
    --repo $RESTIC_REPO_PATH --verbose \
    --read-data >> $RESTIC_LOG 2>&1
