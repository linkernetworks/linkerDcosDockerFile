FROM centos:7
MAINTAINER linkernetworks.com

ENV WORKDIR /usr/local/bin
RUN mkdir -p /var/log/marketplace/

RUN yum -y install vim

ADD swagger-ui.tar.gz ${WORKDIR}
ADD cicd ${WORKDIR}/
ADD cicd.properties ${WORKDIR}/
ADD javaproj_job.xml ${WORKDIR}/
ADD start_cicd.sh ${WORKDIR}/
ADD stop_cicd.sh ${WORKDIR}/

RUN chmod +x ${WORKDIR}/cicd
RUN chmod +x ${WORKDIR}/*.sh

EXPOSE 8082

VOLUME ["/var/log/marketplace"]
CMD ["/usr/local/bin/start_cicd.sh"]


