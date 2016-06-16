#! /bin/bash

#! /bin/bash

line=`dcos marathon app list|grep \/influxdb|wc -l`

echo influxdb installed=$line

if [[ $line -eq 1 ]]; then
   echo influxdb already installed.
else
   echo to install influxdb..
   dcos marathon app add influxdb.json
   echo influxdb already installed.
fi
