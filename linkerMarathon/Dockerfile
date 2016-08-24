FROM centos:7
MAINTAINER ychen <ychen@linkernetworks.com>

RUN rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
RUN yum -y install marathon-0.13.0 mesos-0.26.0 iproute.x86_64

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
