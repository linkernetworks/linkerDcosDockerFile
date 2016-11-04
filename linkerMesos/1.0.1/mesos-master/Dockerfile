FROM linkerrepository/mesos:1.0.1
MAINTAINER ychen <ychen@linkernetworks.com>

ENV MESOS_LOG_DIR /var/log/mesos
ENV MESOS_WORK_DIR /var/lib/mesos
ENV MESOS_REGISTRY replicated_log


ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 5050

VOLUME ["/var/lib/mesos"]

CMD ["/entrypoint.sh"]

