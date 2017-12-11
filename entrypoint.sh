#!/bin/bash
# Inspired from https://github.com/justb4/docker-jmeter
#
# This script expects the standdard JMeter command parameters.
#

set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

WORK_DIR="`pwd`"

echo "START Running Jmeter Container on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "WORK_DIR=${WORK_DIR}"

tail -f bin/jmeter.properties
