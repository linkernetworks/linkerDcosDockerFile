FROM linkerrepository/mesos:0.28.1
MAINTAINER ychen <ychen@linkernetworks.com>

ENV MESOS_LOG_DIR /var/log/mesos
ENV MESOS_WORK_DIR /var/lib/mesos
ENV MESOS_REGISTRY replicated_log

RUN mkdir -p /opt/mesosphere/bin
ADD detect_ip /opt/mesosphere/bin/
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh /opt/mesosphere/bin/detect_ip

EXPOSE 5050

VOLUME ["/var/lib/mesos"]

CMD ["/entrypoint.sh"]

