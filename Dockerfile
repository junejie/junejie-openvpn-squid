FROM ubuntu:16.04

MAINTAINER Junejie Ruzol <junejieruzol1@gmail.com>

RUN apt-get update
RUN apt-get install -y squid3 openvpn iputils-ping dnsutils curl unzip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
