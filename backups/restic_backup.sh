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
SUCCESS=1

check_command() {
    RETVAL=$?
    if [ $RETVAL -ne 0 ]
    then
        SUCCESS=0
    fi
}

# backup
${RESTIC_CMD} backup \
    -p $RESTIC_PASSWORD_FILE \
    --repo $RESTIC_REPO_PATH --verbose \
    --compression $RESTIC_COMPRESSION \
    --exclude-file $RESTIC_EXCLUDE_FILE \
    --files-from $RESTIC_INCLUDE_FILE > $RESTIC_LOG 2>&1

check_command

# forget + prune
${RESTIC_CMD} forget \
    -p $RESTIC_PASSWORD_FILE \
    --repo $RESTIC_REPO_PATH --verbose \
    --keep-daily 3 \
    --keep-weekly 2 \
    --keep-monthly 1 \
    --prune >> $RESTIC_LOG 2>&1

check_command

# check
${RESTIC_CMD} check \
    -p $RESTIC_PASSWORD_FILE \
    --repo $RESTIC_REPO_PATH --verbose \
    --read-data >> $RESTIC_LOG 2>&1

check_command

#
# Gotify notification
#
if [ $SUCCESS -eq 1 ]
then
    MESSAGE="Backup successful"
else
    MESSAGE="Backup failed"
fi

TITLE="Restic Backup"
PRIORITY=7
URL="http://${GOTIFY_IP}:${GOTIFY_PORT}/message?token=${GOTIFY_RESTIC_APPTOKEN}"

curl -s -S --data \
    '{"message": "'"${MESSAGE}"'", "title": "'"${TITLE}"'", "priority":'"${PRIORITY}"', "extras": {"client::display": {"contentType": "text/markdown"}}}' \
    -H 'Content-Type: application/json' "$URL"
