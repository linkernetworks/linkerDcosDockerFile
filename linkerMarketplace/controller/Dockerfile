FROM centos:7
MAINTAINER linkernetworks.com

ENV WORKDIR /usr/local/bin
RUN mkdir -p /var/log/marketplace/

RUN yum -y install vim

ADD swagger-ui.tar.gz ${WORKDIR}
ADD controller ${WORKDIR}/
ADD controller.properties ${WORKDIR}/
ADD policy.json ${WORKDIR}/
ADD start_controller.sh ${WORKDIR}/
ADD stop_controller.sh ${WORKDIR}/

RUN chmod +x ${WORKDIR}/controller
RUN chmod +x ${WORKDIR}/*.sh

EXPOSE 8081

VOLUME ["/var/log/marketplace"]
CMD ["/usr/local/bin/start_controller.sh"]




