FROM alpine
MAINTAINER Zhang Yifa <yzhang3@linkernetworks.com>

USER root
WORKDIR /usr/local/bin

# fix library dependencies, otherwise 'not found' error may occur when executing golang binary.
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY remote-docker-exec /usr/local/bin/remote-docker-exec
COPY gotty /usr/local/bin/gotty
COPY gotty.conf /usr/local/bin/gotty.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/remote-docker-exec /usr/local/bin/gotty /usr/local/bin/entrypoint.sh

EXPOSE 10022

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


# Volume
# /linker/docker/$user/$cluster/certs will be mounted read-only in docker compose.
# Build
# docker build -t linkerrepository/linker_webconsole:latest .
