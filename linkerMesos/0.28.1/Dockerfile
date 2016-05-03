FROM ubuntu:14.04
MAINTAINER ychen <ychen@linkernetworks.com>

RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get -y update && \
    apt-get -y install mesos=0.28.1-2.0.20.ubuntu1404
RUN apt-get -y install curl unzip

RUN echo "set number" >> /etc/vimrc && \
    echo "set ts=4" >> /etc/vimrc && \
    echo "set expandtab" >> /etc/vimrc && \
    echo "set autoindent" >> /etc/vimrc

RUN mkdir -p /var/mesos/external_log && \
    mkdir -p /var/mesos/log && \
    mkdir -p /var/mesos/work
RUN curl -fLsS https://get.docker.com/ | sh


