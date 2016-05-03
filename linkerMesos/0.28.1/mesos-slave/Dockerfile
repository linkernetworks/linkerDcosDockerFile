FROM linkerrepository/mesos:0.28.1
MAINTAINER ychen <ychen@linkernetworks.com>

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 5051

ENV MESOS_CONTAINERIZERS docker,mesos
ENV MESOS_LOG_DIR /var/log/mesos

VOLUME ["/sys/fs/cgroup", "/var/run/docker.sock", "/tmp", "/opt/mesosphere", "/var/log/mesos"]

CMD ["/entrypoint.sh"]

