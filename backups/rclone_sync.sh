#!/usr/bin/env bash
#
# rclone_sync.sh: script to sync local folders into B2Cloud remotes.
#

SCRIPT_PATH=$(dirname -- "$0")
RCLONE_LOG=${SCRIPT_PATH}/rclone.log

# Sync Restic backup
LOCAL_BACKUP_DIR=/media/NAS-home/restic-backup
B2_REMOTE=Restic-B2-Crypt:

# RClone Flags:
# --progress: show progress
# --checksum: filename, filesize and SHA-1 checksum comparison
# --fast-list: more efficient API calls
# --transfers=32: up to 32 parallel transfers ~90MB RAM per transfer
# --bwlimit UPLOAD:DOWNLOAD limit upload and download speeds
RCLONE_FLAGS='--progress --fast-list --transfers=32 --bwlimit=75M'

SUCCESS=1
check_command() {
    RETVAL=$?
    if [ $RETVAL -ne 0 ]
    then
        SUCCESS=0
    fi
}

# RClone Sync command
rclone $RCLONE_FLAGS sync $LOCAL_BACKUP_DIR $B2_REMOTE > $RCLONE_LOG 2>&1
check_command
echo "Restic Offsite Backup complete with size:" >> $RCLONE_LOG 2>&1
rclone size $B2_REMOTE >> $RCLONE_LOG 2>&1
check_command

#
# Gotify notification
#
if [ $SUCCESS -eq 1 ]
then
    MESSAGE="Sync successful"
else
    MESSAGE="Sync failed"
fi

TITLE="RClone Sync"
PRIORITY=7
URL="http://${GOTIFY_IP}:${GOTIFY_PORT}/message?token=${GOTIFY_RCLONE_APPTOKEN}"

curl -s -S --data \
    '{"message": "'"${MESSAGE}"'", "title": "'"${TITLE}"'", "priority":'"${PRIORITY}"', "extras": {"client::display": {"contentType": "text/markdown"}}}' \
    -H 'Content-Type: application/json' "$URL"
