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
TMPFILE="tmpxyzfile"

nvidia-docker ps | grep $DOCKER_IMG_NAME > $TMPFILE
N=`wc -l $TMPFILE | cut -d ' ' -f 1`

if [ $N -gt 1 ]; then
	echo "Multiple instances running!"
elif [ $N -eq 0 ]; then
	echo "No instance to be stopped!"
fi

while read LINE; do
	ID=`echo $LINE | tr -s ' ' | cut -d ' ' -f 1`
	echo "Stopping container $ID..."
	nvidia-docker kill $ID
done < $TMPFILE

screen -ls | grep "fog" > $TMPFILE
N=`wc -l $TMPFILE | cut -d ' ' -f 1`

while read LINE; do
        ID=`echo $LINE | tr -s ' ' | cut -d '.' -f 1`
	echo "Stopping screen $ID..."
        screen -X -S $ID quit
done < $TMPFILE

rm -f $TMPFILE

echo "FoG GPU client was stopped."
