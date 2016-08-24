FROM linkerrepository/dcos-cli:jdk
MAINTAINER Yifa Zhang <yzhang3@linkernetworks.com>

WORKDIR /linker
ENV VERSION 1.0
ENV PATH /opt/local/bin:$PATH
EXPOSE 10004
VOLUME ["/var/log", "/linker/docker"]

RUN mkdir -p /linker /opt/local/bin /linker/smack

COPY *.sh /linker/
COPY docker /opt/local/bin/docker
COPY docker-machine /linker/docker-machine
COPY smack /linker/smack/

RUN chmod +x /linker/docker-machine \
	/opt/local/bin/docker \
	/linker/entrypoint.sh \
	/linker/dbcheck.sh \
	/linker/smack/*.sh

# /linker/docker-compose is in base image
RUN	ln -s /linker/docker-compose /opt/local/bin && \
	ln -s /linker/docker-machine /opt/local/bin

COPY clientmgmt/* /linker/

RUN chmod +x /linker/dcos_client

# ENTRYPOINT ["/linker/entrypoint.sh"]
# CMD ["/linker/entrypoint.sh"]
