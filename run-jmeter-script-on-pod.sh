#!/bin/bash
#
# Run JMeter script on Jmeter POD

JMETER_POD_NAME="jmeter-2150202267-g1vbh" # replace with your Jmeter Pod name

# Finally run
kubectl exec -it ${JMETER_POD_NAME}  -- rm -rf /tmp/jmeter-report
kubectl cp ./jmeter-script ${JMETER_POD_NAME}:/tmp/jmeter-script
kubectl exec -it ${JMETER_POD_NAME}  -- ./bin/jmeter.sh -n -t /tmp/jmeter-script/sample.jmx
rm -rf /tmp/jmeter-report
kubectl cp ${JMETER_POD_NAME}:/tmp/jmeter-report /tmp/jmeter-report
