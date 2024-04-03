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

# check for initialized repo
if ${RESTIC_CMD} -r $RESTIC_REPO_PATH cat config; then
    echo "Repo already initialized"
    exit 0
else
    echo "Initializing new repo..."
    # initialize repo
    ${RESTIC_CMD} init \
        -p $RESTIC_PASSWORD_FILE --verbose \
        --repo $RESTIC_REPO_PATH
    echo "Repository initialized at $RESTIC_REPO_PATH"
fi
