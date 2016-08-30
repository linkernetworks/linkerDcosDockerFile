FROM centos:7
MAINTAINER qye@linkernetworks.com

ENV VERSION 1.0

ENV USERMGMT_DIR /linker
WORKDIR $USERMGMT_DIR

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY user_mgmt/* $USERMGMT_DIR/
COPY entrypoint.sh $USERMGMT_DIR/entrypoint.sh

EXPOSE 10001

RUN chmod +x $USERMGMT_DIR/usermgmt
RUN chmod +x $USERMGMT_DIR/entrypoint.sh

VOLUME ["/var/log"]

ENTRYPOINT ["/linker/entrypoint.sh"]

