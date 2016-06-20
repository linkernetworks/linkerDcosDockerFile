FROM linkerrepository/dcos-cli:jdk

MAINTAINER linker 

ENV VERSION 1.0

RUN mkdir -p /opt/local/bin
ENV PATH=/opt/local/bin:$PATH

ADD clientmgmt/dcos_client /usr/local/bin/dcos_client
ADD clientmgmt/dcos_client.properties /usr/local/bin/dcos_client.properties
ADD clientmgmt/swagger-ui /usr/local/bin/swagger-ui

ADD dbcheck.sh /usr/local/bin/dbcheck.sh
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD docker-machine /opt/local/bin/docker-machine
ADD docker /opt/local/bin/docker

RUN chmod +x /usr/local/bin/dcos_client
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/dbcheck.sh
RUN chmod +x /opt/local/bin/docker-machine
RUN chmod +x /opt/local/bin/docker

RUN mkdir -p /opt/local/smack
ADD smack /opt/local/smack/
RUN chmod +x /opt/local/smack/*.*

EXPOSE 10004

VOLUME ["/var/log", "/linker/docker"]

#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
#CMD ["/usr/local/bin/entrypoint.sh"]

