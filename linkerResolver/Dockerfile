FROM ubuntu:14.04

ENV RESOLVERS 114.114.114.114
ENV MASTER_SOURCE env

# install dnspython package
ADD dnspython3-1.12.0.tar.gz /
RUN cd /dnspython3-1.12.0 && python3 setup.py install

COPY gen_resolvconf.py /
COPY entrypoint.sh /

RUN chmod +x /gen_resolvconf.py /entrypoint.sh

CMD ["/entrypoint.sh"]
