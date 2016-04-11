FROM linkerrepository/dcos-cli

MAINTAINER linker 

ENV VERSION 1.0

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN  apt-get -y update && \
     apt-get -y install vim && \
     apt-get -y install unzip

ADD clientmgmt/dcos_client /usr/local/bin/dcos_client

ADD clientmgmt/dcos_client.properties /usr/local/bin/dcos_client.properties

ADD clientmgmt/swagger-ui /usr/local/bin/swagger-ui

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ADD docker-machine /opt/local/bin/docker-machine

RUN chmod +x /usr/local/bin/dcos_client

RUN chmod +x /usr/local/bin/entrypoint.sh

RUN chmod +x /opt/local/bin/docker-machine

EXPOSE 10004

VOLUME ["/var/log"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

