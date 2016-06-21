#! /bin/bash

#! /bin/bash

line=`dcos marathon app list|grep \/hdfs|wc -l`

echo hdfs installed=$line

if [[ $line -eq 1 ]]; then
   echo hdfs already installed.
else
   echo to install hdfs..
   dcos marathon app add hdfs.json
   echo hdfs already installed.
fi
