FROM ubuntu:14.04
MAINTAINER Mike Gering <mike@mfg-consulting-llc.com>

ENV DANTE_VER 1.4.2
ENV DANTE_URL https://www.inet.no/dante/files/dante-$DANTE_VER.tar.gz
ENV DANTE_SHA baa25750633a7f9f37467ee43afdf7a95c80274394eddd7dcd4e1542aa75caad
ENV DANTE_FILE dante.tar.gz
ENV DANTE_TEMP dante
ENV DANTE_DEPS build-essential curl

# Create OpenVPN conf directory
RUN mkdir -p /vol/config

RUN set -xe \
    && apt-get update \
    && apt-get install -y openvpn net-tools \
    && apt-get install -y $DANTE_DEPS \
    && mkdir $DANTE_TEMP \
        && cd $DANTE_TEMP \
        && curl -sSL $DANTE_URL -o $DANTE_FILE \
        && echo "$DANTE_SHA *$DANTE_FILE" | shasum -c \
        && tar xzf $DANTE_FILE --strip 1 \
        && ./configure \
        && make install \
        && cd .. \
        && rm -rf $DANTE_TEMP \
    && apt-get install -y curl unrar-free zip unzip wget \
    && curl -sLO https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64.deb \
    && curl -L https://github.com/jwilder/dockerize/releases/download/v0.4.0/dockerize-linux-amd64-v0.4.0.tar.gz | tar -C /usr/local/bin -xzv \    
    && dpkg -i dumb-init_*.deb \
    && rm -rf dumb-init_*.deb \
    && rm -rf /var/lib/apt/lists/* \
    && true

COPY sockd.conf /etc/sockd.conf
COPY start_dante.sh /usr/sbin/start_dante.sh
COPY stop_dante.sh /usr/sbin/stop_dante.sh
COPY start_openvpn.sh /usr/sbin/start_openvpn.sh
COPY dante-env-vars.tmpl /etc/dante/dante-env-vars.tmpl

ENV CFGFILE /etc/sockd.conf
ENV PIDFILE /tmp/sockd.pid
ENV WORKERS 10
ENV OPENVPN_CONFIG /vol/config/openvpn.conf

EXPOSE 1080

# Set working directory
WORKDIR /vol/config

# Defualt entrypoint and run command
ENTRYPOINT ["dumb-init", "/usr/sbin/start_openvpn.sh"]
