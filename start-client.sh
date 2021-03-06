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
ARCH=`uname -m`

# check if there is nvidia-docker and screen
command -v nvidia-docker >/dev/null 2>&1 || { echo >&2 "Please install 'nvidia-docker'. See the intructions at https://github.com/greenedge-io/gpu-client."; exit 1; }
command -v nvidia-docker >/dev/null 2>&1 || { echo >&2 "Please install 'screen' by typing 'sudo apt install screen'"; exit 1; }

# check and update config file
if [ -f $CFGFILE ]; then
	EMAIL=`head -n 1 $CFGFILE`
	SECRET=`tail -n 1 $CFGFILE`
else
	echo "Please enter the email address you have registered on greenedge.io:"
	read EMAIL
	echo $EMAIL > $CFGFILE
	echo "Please enter your secret generated by greenedge.io:"
	read SECRET
	echo $SECRET >> $CFGFILE
	echo "Email address and secret saved to $CFGFILE"
fi

# get all Nvidia GPUs
CMD_GPUINFO="./getdevinfo-$ARCH"
if [ -e $CMD_GPUINFO ]; then 
	GPUS=`$CMD_GPUINFO | grep "Found" | cut -d ' ' -f 2`
else
	echo "Auxiliary scripts not found! Please contact us at info@greenedge.io"
	exit 1
fi 

# kill existing running instances
./stop-client.sh

# pull the latest image
nvidia-docker pull $DOCKER_IMG_NAME

# start new instances and monitor
echo "Starting FoG client on $GPUS GPU(s)..."
for GPU in `seq 1 $GPUS`; do
	GPU_ID=$(($GPU-1))
	screen -S "fog-$GPU_ID" -d -m ./run-client.sh $GPU_ID 
	SCR=`screen -ls | grep "fog-$GPU_ID" | tr -s ' ' | cut -d '.' -f 1`
	echo "You can monitor the behavior of FoG GPU client on GPU $GPU_ID by connecting to the screen: 'screen -r $SCR'"
	sleep 1
done

