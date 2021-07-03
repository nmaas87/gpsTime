#!/bin/bash

# install dependencies
apt update
apt install -t buster-backports -y gpsd gpsd-clients chrony pps-tools
apt install -t buster-backports -y --no-install-recommends python-gi-cairo
apt clean -y
apt autoremove -y
