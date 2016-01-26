FROM centos:7
RUN yum -y install epel-release &&\
	yum -y install nodejs &&\
	yum -y install unzip
	
RUN mkdir -p /opt/linker-dcos-portal/

COPY linker-dcos-portal.zip /opt/linker-dcos-portal/linker-dcos-portal.zip
COPY init.sh /opt/linker-dcos-portal/init.sh

RUN chmod 755 /opt/linker-dcos-portal/*.sh

WORKDIR /opt/linker-dcos-portal

EXPOSE 3000

VOLUME ["/var/log"]

ENV NODE_ENV production

ENTRYPOINT /opt/linker-dcos-portal/init.sh