FROM centos:centos7
MAINTAINER ychen <ychen@linkernetworks.com>

#java runtime env
RUN yum -y update &&\
    yum -y install java-1.8.0-openjdk.x86_64 iproute.x86_64

RUN mkdir -p /data/runtime && \
    mkdir -p /data/datalogs && \
    mkdir -p /data/zookeeper/log && \
    mkdir -p /data/zookeeper/snapshot && \
    mkdir -p /data/zookeeper/zkLog

RUN curl -fL http://apache.fayea.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar xzf - -C /usr
ADD zookeeper.cfg /usr/zookeeper-3.4.6/conf/
ADD init.sh /

RUN chmod 755 init.sh
