FROM schmunk42/docker-toolbox:latest

MAINTAINER zhangjie0220@gmail.com

WORKDIR /linker

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# copy binarys and make them executable
COPY bin/* /tmp/linker/
RUN chmod +x /tmp/linker/* &&\
    mv /tmp/linker/docker* /opt/local/bin/ &&\
    mv /tmp/linker/entrypoint.sh /entrypoint.sh 

# copy linker components and make binary and shell file executable
COPY linker /tmp/linker
RUN chmod +x /tmp/linker/bin/* &&\
    mv /tmp/linker/bin/* /linker/ &&\
    mv /tmp/linker/config /linker/ &&\
    mv /tmp/linker/prometheus /linker/ &&\
    mv /tmp/linker/alertmanager /linker/ &&\
    mv /tmp/linker/marathon /linker/

EXPOSE 10003

#Expose the config and log folder
VOLUME ["/linker/docker","/linker/swarm","/var/log"]

CMD ["/entrypoint.sh"]
