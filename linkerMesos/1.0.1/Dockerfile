FROM ubuntu:14.04
MAINTAINER ychen <ychen@linkernetworks.com>

ENV VERSION 1.0.1

RUN apt-get update && \
    apt-get -y install curl unzip

RUN echo "set number" >> /etc/vimrc && \
    echo "set ts=4" >> /etc/vimrc && \
    echo "set expandtab" >> /etc/vimrc && \
    echo "set autoindent" >> /etc/vimrc

RUN mkdir -p /var/mesos/external_log && \
    mkdir -p /var/mesos/log && \
    mkdir -p /var/mesos/work

RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install mesos=$(apt-cache madison mesos | grep " ${VERSION}" | awk '{print $3}')

