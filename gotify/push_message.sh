#!/usr/bin/env bash

#
# Example script to send a message to Gotify
# check documentation for more details or other languages
#

# EDIT THESE LINES
GOTIFY_IP=[YOUR_GOTIFY_IP]
APPTOKEN=[YOUR_APP_TOKEN]
PORT=8080

TITLE="Test title"
MESSAGE="This is a test message"
PRIORITY=7
URL="http://${GOTIFY_IP}:${PORT}/message?token=${APPTOKEN}"

curl -s -S --data \
    '{"message": "'"${MESSAGE}"'", "title": "'"${TITLE}"'", "priority":'"${PRIORITY}"', "extras": {"client::display": {"contentType": "text/markdown"}}}' \
    -H 'Content-Type: application/json' "$URL"
