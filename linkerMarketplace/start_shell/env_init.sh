#!/bin/bash

# linker_marketplace 10.10.10.18 172.19.30.35   mongo, zookeeper, mesos-master, mesos-slave, marathon
# centosgo 192.168.5.141 marketplace controller, marketplace cicd, marketplace ui

ZOOKEEPERLIST=10.10.10.18:2888:3888
MESOS_ZK=zk://10.10.10.18:2181/mesos
MESOS_MASTER=zk://10.10.10.18:2181/mesos
MARATHON_MASTER=zk://10.10.10.18:2181/mesos
MARATHON_ZK=zk://10.10.10.18:2181/marathon
MESOS_HOSTNAME_LOOKUP=false

