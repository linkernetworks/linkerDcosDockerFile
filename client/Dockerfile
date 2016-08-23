FROM linkerrepository/linkerdcos_client:1.1.2

#RUN rm -rf /linker/docker-machine /linker/docker-compose /linker/docker

ADD docker-machine /linker/docker-machine
ADD docker-compose /linker/docker-compose
ADD docker /opt/local/bin/docker

RUN \
    rm -rf /opt/local/bin/docker-* &&\
    ln -s /linker/docker-machine /opt/local/bin/docker-machine &&\
    ln -s /linker/docker-compose /opt/local/bin/docker-compose &&\
    chmod +x /opt/local/bin/docker*

EXPOSE 10004

