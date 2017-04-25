FROM vimagick/dante
MAINTAINER Mike Gering <mike@mfg-consulting-llc.com>

ADD sockd.conf /etc/sockd.conf
ADD start_socks.sh /usr/bin/start_socks.sh

RUN apt-get update \
  && apt-get install net-tools \
  && true

CMD /usr/bin/start_socks.sh