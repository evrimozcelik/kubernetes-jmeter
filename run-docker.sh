#!/bin/bash
# Inspired from https://github.com/justb4/docker-jmeter
#
# Run JMeter Docker image with options

NAME="jmeter"
IMAGE="registry.eu-gb.bluemix.net/evrim/jmeter"

# Use the current working dir
WORK_DIR="`pwd`"

# Finally run
sudo docker stop ${NAME} > /dev/null 2>&1
sudo docker rm ${NAME} > /dev/null 2>&1
sudo docker run --name ${NAME} -i -v ${WORK_DIR}:${WORK_DIR} -w ${WORK_DIR} ${IMAGE} $@
