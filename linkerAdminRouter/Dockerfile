FROM linkerrepository/openresty:debian
MAINTAINER support@linkernetworks.com

# Add dcos-ui
RUN mkdir -p /opt/mesosphere/active/dcos-metadata/etc
COPY contents/dcos-version.json /opt/mesosphere/active/dcos-metadata/etc/dcos-version.json
COPY contents/dcos-ui /opt/mesosphere/active/dcos-ui
COPY start.sh /start.sh

# add nginx reload cron job
RUN chmod 755 /start.sh && \
 echo "*/1 * * * * root /opt/openresty/nginx/sbin/nginx -s reload" >> /etc/cron.d/nginx
#RUN echo "*/1 * * * * root echo \$(date) cron >> /var/log/cron.log" >> /etc/cron.d/test

EXPOSE 80

CMD ["/start.sh"]
