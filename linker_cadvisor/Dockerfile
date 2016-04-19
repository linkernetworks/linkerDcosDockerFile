FROM centos:7
MAINTAINER linkernetworks.com

USER root

RUN yum -y update && \
    yum -y install python-setuptools vim expect && \
    mkdir -p /opt/itri && \
    ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY cadvisor /usr/local/bin/cadvisor
RUN chmod +x /usr/local/bin/cadvisor

EXPOSE 10000

ENTRYPOINT ["/usr/local/bin/cadvisor", "--port", "10000"]
