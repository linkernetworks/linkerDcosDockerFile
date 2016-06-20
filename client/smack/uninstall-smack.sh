#! /bin/bash

echo to uninstall zeppelin
dcos package uninstall zeppelin

echo 
echo to uninstall tweeter
dcos marathon app remove --force tweeter


echo
echo to uninstall hdfs
dcos marathon app remove hdfs

echo
echo to uninstall spark
dcos package uninstall spark
./zk -zk master.mesos:2181 -path /spark_mesos_dispatcher

echo
echo to uninstall cassandra
dcos package uninstall cassandra
./zk -zk master.mesos:2181 -path /cassandra-mesos

echo
echo to uninstall kafka
dcos package uninstall kafka
