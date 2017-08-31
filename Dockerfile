FROM ubuntu:16.04

MAINTAINER Junejie Ruzol <junejieruzol1@gmail.com>

RUN apt-get update
RUN apt-get install -y squid3
RUN apt-get install -y openvpn
RUN apt-get install -y iputils-ping
RUN apt-get install -y dnsutils
RUN apt-get install -y curl

ENV VPN_USER testuser
ENV VPN_PASS testpass
ENV OVPN_FILENAME testfilename
# RUN apt-get clean && \
#     rm -rf /var/cache/apt/* && \
#     rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
