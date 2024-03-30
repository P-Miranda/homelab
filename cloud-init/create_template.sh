#!/usr/bin/env bash

ENV_FILE=.env

if [ -f $ENV_FILE ]
then
  source $ENV_FILE
else
  echo "No .env file found."
  exit 1
fi

qm create $ID --name $NAME --ostype l26
qm set $ID --net0 virtio,bridge=vmbr0
qm set $ID --serial0 socket --vga serial0
qm set $ID --memory 2048 --cores 2 --cpu host
qm set $ID --balloon 0
qm set $ID --scsi0 ${STORAGE}:0,ssd=1,import-from="$(pwd)/${ISO}",discard=on
qm set $ID --agent enabled=1,fstrim_cloned_disks=1
qm set $ID --boot order=scsi0 --scsihw virtio-scsi-single
qm set $ID --ide2 ${STORAGE}:cloudinit
qm set $ID --ipconfig0 "ip6=auto,ip=dhcp"
# qm set $ID --bios ovmf \
#     --efidisk0 local-lvm:1,format=qcow2,efitype=4m,pre-enrolled-keys=1
qm set $ID --ciuser $USER
qm set $ID --sshkeys ${SSH_KEYFILE}
qm set $ID --cipassword $PASSWORD
qm disk resize $ID scsi0 10G
qm template $ID
