FROM linkerrepository/mesos:0.28.1
MAINTAINER ychen <ychen@linkernetworks.com>

# install docker using default installation script
RUN curl -sSL https://s3-ap-southeast-1.amazonaws.com/docker-engine/v1.12.0/docker-install.sh | sh -

#RUN systemctl stop docker.service && systemctl disable docker.service
RUN apt-get install curl -y && apt-get install libcurl3-nss -y

ADD post_launch_docker_hook.json /opt/post_launch_docker_hook.json
ADD linkerconfig /opt/linkerconfig
ADD so/libmesos-0.28.1.so /usr/lib/libmesos-0.28.1.so
ADD so/libmesos.la /usr/lib/libmesos.la
ADD so/libpostlaunchdockerhook-0.28.1.so /usr/lib/mesos/modules/libpostlaunchdockerhook-0.28.1.so
ADD so/libpostlaunchdockerhook.la /usr/lib/mesos/modules/libpostlaunchdockerhook.la
ADD libexec/mesos-containerizer /usr/libexec/mesos/mesos-containerizer
ADD libexec/mesos-docker-executor /usr/libexec/mesos/mesos-docker-executor
ADD libexec/mesos-executor /usr/libexec/mesos/mesos-executor
ADD libexec/mesos-fetcher /usr/libexec/mesos/mesos-fetcher
ADD libexec/mesos-health-check /usr/libexec/mesos/mesos-health-check
ADD libexec/mesos-logrotate-logger /usr/libexec/mesos/mesos-logrotate-logger
ADD libexec/mesos-usage /usr/libexec/mesos/mesos-usage

RUN chmod +x /opt/linkerconfig && \
	ln -s /usr/lib/mesos/modules/libpostlaunchdockerhook-0.28.1.so /usr/lib/mesos/modules/libpostlaunchdockerhook.so && \
	chmod +x /usr/lib/*.so && \
	chmod +x /usr/lib/mesos/modules/*.so && \
	chmod +x /usr/lib/*.la && \
	chmod +x /usr/lib/mesos/modules/*.la && \
	chmod +x /usr/libexec/mesos/*

ENV MESOS_MODULES file:///opt/post_launch_docker_hook.json
ENV MESOS_HOOKS org_apache_mesos_PostLaunchDockerHook

EXPOSE 5051

ENV MESOS_CONTAINERIZERS docker,mesos
ENV MESOS_LOG_DIR /var/log/mesos

ADD entrypoint.sh /
ADD detect_ip /
RUN chmod +x /entrypoint.sh /detect_ip

VOLUME ["/sys/fs/cgroup", "/var/run/docker.sock", "/tmp", "/opt/mesosphere", "/var/log/mesos"]

CMD ["/entrypoint.sh"]

