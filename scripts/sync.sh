#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <user> <machine>"
    exit 1
fi

user=$1
machine=$2

RSYNC_FLAGS="-a"

echo "Deleting existing homelab directory on $machine"
ssh $user@$machine 'sudo rm -rf ~/homelab'

echo "Copying files to $machine"
rsync $RSYNC_FLAGS . $user@$machine:homelab
