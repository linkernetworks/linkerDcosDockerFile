#! /bin/bash

#! /bin/bash

line=`dcos marathon app list|grep \/influxdb|wc -l`
node0ip=`dcos node|grep -v "HOSTNAME"|head -1|awk '{print $1}'`

echo influxdb installed=$line

if [[ $line -eq 1 ]]; then
   echo influxdb already installed.
else
   echo node0ip=$node0ip
   rm -f influxdb.json
   cp influxdb_template.json influxdb.json
   sed -i s/placeholder/$node0ip/ influxdb.json

   echo to install influxdb..
   dcos marathon app add influxdb.json
   echo influxdb already installed.
fi
