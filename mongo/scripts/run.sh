#!/bin/bash


# First setup 
if [[ ! -e /data/db ]]; then
	mkdir -p /data/db
fi


if [[ ! -e /data/.alreadyrun ]]; then
	touch /data/.alreadyrun
    /scripts/firstRun.sh
else  # start by marathon after shutdown
    /scripts/runAsSlave.sh
fi

