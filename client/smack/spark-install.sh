#!/bin/bash

line=`dcos package list|grep spark |awk '{print $3}'|grep spark|wc -l`

echo spark installed=$line

sparkAddr=""
function getSparkAddr(){
  serviceJson=`curl -s master.mesos:8123/v1/services/_spark._tcp.marathon.mesos`

  if [[ $serviceJson == "" ]]; then
    echo service not exist
  else
    sparkAddr=`python spark-help.py`
  fi
}

function waitSparkFrameworkStartup(){
  while true; do
    getSparkAddr
    if [[ $sparkAddr != "" && $sparkAddr != ":" ]]; then
      state=`curl -s $sparkAddr|grep html|wc -l`
      echo spark.state=$state
      if [[ $state -gt 0 ]]; then
        echo spark framework startup!
        return;
      else
        echo spark health exception, wait for framework start...
        sleep 2
      fi
    else
      sleep 2
      echo wait for framework start .. 
      #wait for framework start
    fi
  done
}



if [[ $line -eq 1 ]]; then
   echo spark already installed
else
   echo to install spark
   echo to clear spark on zk
   ./zk -zk master.mesos:2181 -path /spark_mesos_dispatcher
   echo clear spark on zk finish
   dcos package install --yes spark
fi

waitSparkFrameworkStartup
