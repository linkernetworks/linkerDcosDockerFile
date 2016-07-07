#! /bin/bash

echo check to install kafka
./kafka-install.sh
echo ------------------------------------------------------------
echo
echo 


echo check to install cassandra
./cassandra-install.sh
echo ------------------------------------------------------------
echo
echo 

./spark-install.sh
echo ------------------------------------------------------------
echo
echo 


echo check to install tweeter
./tweeter-install.sh
echo ------------------------------------------------------------
echo
echo 

echo check to install zeppelin
./zeppelin-install.sh
echo ------------------------------------------------------------
echo
echo


echo check to install iot-dashboard influxdb,grafana,hdfs
./iot-dashboard-install.sh
echo ------------------------------------------------------------
echo 
echo


#echo all components install finish.
