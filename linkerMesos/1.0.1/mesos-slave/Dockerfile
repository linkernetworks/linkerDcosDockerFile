FROM linkerrepository/mesos:1.0.1
MAINTAINER ychen <ychen@linkernetworks.com>

# install docker using default installation script
RUN curl -sSL https://s3-ap-southeast-1.amazonaws.com/docker-engine/v1.12.0/docker-install.sh | sh -

# instal dvdcli for docker/volume
RUN curl -sSL https://dl.bintray.com/emccode/dvdcli/install | sh -s stable

# install rexray and contiv for aws's ebs and ceph
#RUN curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -s -- stable 0.3.3

EXPOSE 5051

ENV MESOS_CONTAINERIZERS docker,mesos
ENV MESOS_LOG_DIR /var/log/mesos

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME ["/sys/fs/cgroup", "/var/run/docker.sock", "/tmp", "/opt/mesosphere", "/var/log/mesos"]

CMD ["/entrypoint.sh"]

