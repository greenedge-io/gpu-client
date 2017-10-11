#!/bin/bash
###############################################
#
# Copyright (c) 2017 - Dumitrel Loghin
#
# This script is part of FoG (fog.greenedge.io)
#
###############################################
#
DOCKER_IMG_NAME="dloghin/fog-amd64"
CFGFILE=".config"
STATFILE=".status"
SLEEP_TIME="10"

nvidia-docker run $DOCKER_IMG_NAME:latest &
sleep 1
ID=`nvidia-docker ps | grep $DOCKER_IMG_NAME | head -n 1 | tr -s ' ' | cut -d ' ' -f 1`
echo "Container $ID started"
nvidia-docker cp $CFGFILE $ID:/

