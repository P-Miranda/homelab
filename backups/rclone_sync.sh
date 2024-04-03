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

# RClone Sync command
rclone $RCLONE_FLAGS sync $LOCAL_BACKUP_DIR $B2_REMOTE > $RCLONE_LOG 2>&1
echo "Restic Offsite Backup complete with size:" >> $RCLONE_LOG 2>&1
rclone size $B2_REMOTE >> $RCLONE_LOG 2>&1
