#! /bin/bash

#! /bin/bash

line=`dcos marathon app list|grep \/grafana|wc -l`
node0ip=`dcos node|grep -v "HOSTNAME"|tail -1|awk '{print $1}'`


echo grafana installed=$line

if [[ $line -eq 1 ]]; then
   echo grafana already installed.
else
   echo node0ip=$node0ip
   rm -f grafana.json
   cp grafana_template.json grafana.json
   sed -i s/placeholder/$node0ip/ grafana.json

   echo to install grafana..
   dcos marathon app add grafana.json
   echo grafana already installed.
fi
