FROM centos:7
RUN yum -y install epel-release &&\
	yum -y install redis 
	
RUN mkdir -p /opt/linker-dcos-portal/
RUN mkdir -p /var/log/redis/

COPY init.sh /opt/linker-dcos-portal/init.sh

RUN chmod 755 /opt/linker-dcos-portal/*.sh

WORKDIR /opt/linker-dcos-portal/

EXPOSE 6379

VOLUME ["/var/log/redis"]

ENTRYPOINT /opt/linker-dcos-portal/init.sh
