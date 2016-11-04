FROM centos:centos7
MAINTAINER ychen <ychen@linkernetworks.com>

RUN yum -y update
RUN rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
RUN yum -y install marathon-1.3.0 mesos-1.0.1
RUN yum -y install iproute.x86_64

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENV MARATHON_LOGGING_LEVEL warn

CMD ["/entrypoint.sh"]
