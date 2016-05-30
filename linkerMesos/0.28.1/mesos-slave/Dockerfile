FROM linkerrepository/mesos:0.28.1
MAINTAINER ychen <ychen@linkernetworks.com>

# install docker using default installation script
RUN curl -sSL https://s3-ap-southeast-1.amazonaws.com/docker-engine/default/docker-install.sh | sh -

#RUN systemctl stop docker.service && systemctl disable docker.service

EXPOSE 5051

ENV MESOS_CONTAINERIZERS docker,mesos
ENV MESOS_LOG_DIR /var/log/mesos

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME ["/sys/fs/cgroup", "/var/run/docker.sock", "/tmp", "/opt/mesosphere", "/var/log/mesos"]

CMD ["/entrypoint.sh"]

