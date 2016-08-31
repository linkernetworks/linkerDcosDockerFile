FROM centos:7

RUN yum install -y epel-release nodejs unzip && \
	mkdir -p /opt/linker-dcos-portal/

WORKDIR /opt/linker-dcos-portal
ENV NODE_ENV production

EXPOSE 3000
VOLUME ["/var/log"]

COPY init.sh /opt/linker-dcos-portal/init.sh
COPY linker-dcos-portal.zip /opt/linker-dcos-portal/linker-dcos-portal.zip
RUN chmod 755 /opt/linker-dcos-portal/*.sh

ENTRYPOINT /opt/linker-dcos-portal/init.sh
