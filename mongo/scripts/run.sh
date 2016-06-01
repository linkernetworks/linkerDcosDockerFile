#!/bin/bash

mongoReplication() {
    echo "start mongodb in replication mode"
	# First setup 
    if [[ ! -e /data/.alreadyrun ]]; then
          touch /data/.alreadyrun
          /scripts/firstRun.sh
    else  # start by marathon after shutdown
          /scripts/runAsSlave.sh
    fi
}


mongoStandalone() {
	echo "start mongodb in standaone mode"
	/scripts/runStandalone.sh
}


if [[ ! -e /data/db ]]; then
  	mkdir -p /data/db
fi

array=(${MONGODB_NODES//,/ })
len=${#array[@]}
if [[ $len -gt 1 ]]; then
	mongoReplication
else
	mongoStandalone
fi



