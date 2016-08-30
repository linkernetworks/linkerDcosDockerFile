FROM alpine
MAINTAINER Zhang Yifa <yzhang3@linkernetworks.com>

USER root
WORKDIR /usr/local/bin
EXPOSE 10022

# fix library dependencies, otherwise 'not found' error may occur when executing golang binary.
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# volume will be mount to host
RUN mkdir -p /usr/local/bin/certs

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY gotty.conf /usr/local/bin/gotty.conf
COPY remote-docker-exec /usr/local/bin/remote-docker-exec
COPY gotty /usr/local/bin/gotty

RUN chmod +x /usr/local/bin/remote-docker-exec \
			/usr/local/bin/gotty \
			/usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
