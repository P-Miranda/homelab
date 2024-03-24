#!/usr/bin/env bash

SRC_PATH="../pihole"
ETC_PIHOLE="etc-pihole"
ETC_DNSMASQ="etc-dnsmasq.d"

# remove existing files
rm -rf $ETC_PIHOLE $ETC_DNSMASQ

# copy configs from SRC_PATH
cp -r $SRC_PATH/$ETC_PIHOLE .
cp -r $SRC_PATH/$ETC_DNSMASQ .
