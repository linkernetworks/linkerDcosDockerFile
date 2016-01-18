FROM centos:centos7
MAINTAINER ychen <ychen@linkernetworks.com>

RUN yum -y update
RUN rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
RUN yum -y install marathon-0.13.0 mesos-0.26.0
RUN yum -y install iproute.x86_64

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
