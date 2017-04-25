FROM ubuntu
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Define OpenVPN version
ARG OVPN_VERSION=2.3.14-r0

# Create OpenVPN conf directory
RUN mkdir -p /vol/config

RUN set -xe \
    && apt-get update \
    && apt-get install -y openvpn net-tools \
    && rm -rf /var/lib/apt/lists/* \
    && true
#    && mkdir -p /dev/net \
#    && mknod /dev/net/tun c 10 200 \
#    && chmod 600 /dev/net/tun \

# Install OpenVPN
#RUN apk add --update openvpn=${OVPN_VERSION} && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /vol/config

# Defualt entrypoint and run command
ENTRYPOINT ["openvpn", "--config", "/vol/config/openvpn.conf", "--verb", "3", "--remap-usr1", "SIGTERM"]
#CMD ["--script-security", "2", "--up", "/etc/openvpn/up.sh", "--down", "/etc/openvpn/down.sh"]