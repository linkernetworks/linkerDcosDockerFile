FROM linkerrepository/dcos-cli:0.4.6

MAINTAINER linker <support@linkernetworks.com> 

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
ADD docker-compose /linker/docker-compose
ADD docker /opt/local/bin/docker

RUN \
    rm -rf /opt/local/bin/docker-* &&\
    ln -s /linker/docker-machine /opt/local/bin/docker-machine &&\
    ln -s /linker/docker-compose /opt/local/bin/docker-compose &&\
    chmod +x /opt/local/bin/docker* &&\
    chmod +x /linker/dcos_client &&\
    chmod +x /linker/entrypoint.sh &&\
    chmod +x /linker/dbcheck.sh

# install smack
RUN mkdir -p /linker/smack
ADD smack /linker/smack/
RUN chmod +x /linker/smack/*.sh

EXPOSE 10004

VOLUME ["/var/log", "/linker/docker"]

