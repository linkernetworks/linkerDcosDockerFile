FROM linkerrepository/dcos-cli:jdk

MAINTAINER linker 

ENV VERSION 1.0

RUN mkdir -p /linker
RUN mkdir -p /opt/local/bin
ENV PATH=/opt/local/bin:$PATH

ADD clientmgmt/dcos_client /linker/dcos_client
ADD clientmgmt/dcos_client.properties /linker/dcos_client.properties
ADD clientmgmt/swagger-ui /linker/swagger-ui

ADD dbcheck.sh /linker/dbcheck.sh
ADD entrypoint.sh /linker/entrypoint.sh
ADD docker-machine /linker/docker-machine
ADD docker /opt/local/bin/docker
RUN ln -s /linker/docker-machine /opt/local/bin
RUN ln -s /linker/docker-compose /opt/local/bin

RUN chmod +x /linker/dcos_client
RUN chmod +x /linker/entrypoint.sh
RUN chmod +x /linker/dbcheck.sh
RUN chmod +x /linker/docker-machine
RUN chmod +x /opt/local/bin/docker

RUN mkdir -p /linker/smack
ADD smack /linker/smack/
RUN chmod +x /linker/smack/*.sh

EXPOSE 10004

VOLUME ["/var/log", "/linker/docker"]

#ENTRYPOINT ["/linker/entrypoint.sh"]
#CMD ["/linker/entrypoint.sh"]

