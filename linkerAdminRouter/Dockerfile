FROM ficusio/openresty:debian
MAINTAINER support@linkernetworks.com

# Add nginx configurations
#COPY contents/conf /opt/openresty/nginx/conf
#COPY contents/lualib /opt/openresty/nginx/lualib

COPY nginx /opt/openresty/nginx

# Add dcos-ui
RUN mkdir -p /opt/mesosphere/active
COPY contents/dcos-ui /opt/mesosphere/active/dcos-ui

EXPOSE 80
