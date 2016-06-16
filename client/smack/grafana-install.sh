#! /bin/bash

#! /bin/bash

line=`dcos marathon app list|grep \/grafana|wc -l`

echo grafana installed=$line

if [[ $line -eq 1 ]]; then
   echo grafana already installed.
else
   echo to install grafana..
   dcos marathon app add grafana.json
   echo grafana already installed.
fi
