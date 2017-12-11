#!/bin/bash

JMETER_VERSION="3.3"
NAMESPACE="evrim"

# Example build line
# --build-arg IMAGE_TIMEZONE="Europe/Amsterdam"
docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} -t registry.eu-gb.bluemix.net/${NAMESPACE}/jmeter .
