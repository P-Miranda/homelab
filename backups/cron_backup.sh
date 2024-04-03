#!/usr/bin/env bash

SCRIPT_PATH=$(dirname -- "$0")
# Restic backup script
${SCRIPT_PATH}/restic_backup.sh

# Rclone remote sync
${SCRIPT_PATH}/rclone_sync.sh
