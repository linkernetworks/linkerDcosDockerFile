FROM centos:7
MAINTAINER linkernetworks.com

ENV WORKDIR /usr/local/bin
ENV LINKER_CONF_DIR /usr/local/bin/linker_controller_portal/portal-server/conf
RUN mkdir -p /var/log/marketplace/

RUN yum -y install vim
RUN yum -y install epel-release && yum -y install nodejs

ADD linker_controller_portal.tar.gz ${WORKDIR}
ADD start_ui.sh ${WORKDIR}/
ADD stop_ui.sh ${WORKDIR}/
RUN rm -fr ${LINKER_CONF_DIR}/linker-portal.json
ADD linker-portal.json ${LINKER_CONF_DIR}/

RUN chmod +x ${WORKDIR}/*.sh

EXPOSE 3000

VOLUME ["/var/log/marketplace"]
CMD ["/usr/local/bin/start_ui.sh"]

