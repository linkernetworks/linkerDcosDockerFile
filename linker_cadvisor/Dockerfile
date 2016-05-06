FROM centos:7
MAINTAINER linkernetworks.com

USER root

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

EXPOSE 10000
ENTRYPOINT ["/usr/local/bin/cadvisor", "--port", "10000"]

COPY cadvisor /usr/local/bin/cadvisor
RUN chmod +x /usr/local/bin/cadvisor
