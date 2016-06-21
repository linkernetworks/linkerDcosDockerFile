#! /bin/bash

#echo to uninstall zeppelin
#dcos package uninstall zeppelin

echo 
echo to uninstall tweeter
curl -X DELETE  --header 'Content-Type: */*' --header 'Accept: application/json' 'http://localhost:10004/v1/appsets/tweeter'

echo
echo to uninstall spark
dcos package uninstall spark
./zk -zk master.mesos:2181 -path /spark_mesos_dispatcher

echo
cho to uninstall cassandra
dcos package uninstall cassandra
./zk -zk master.mesos:2181 -path /cassandra-mesos

echo
echo to uninstall kafka
dcos package uninstall kafka

echo
echo to uninstall grafana\hdfs\influxdb
curl -X DELETE  --header 'Content-Type: */*' --header 'Accept: application/json' 'http://localhost:10004/v1/appsets/iot-dashboard'

