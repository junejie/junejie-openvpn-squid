#!/bin/bash

echo "saving vpn credentials"
echo $VPN_USER >> /data/auth.txt
echo $VPN_PASS >> /data/auth.txt

echo "Updating Squid Config"
sed -i '/acl localnet src 172.16.0.0\/12/s/^#//g' /etc/squid/squid.conf
sed -i '/http_access allow localnet/s/^#//g' /etc/squid/squid.conf

# support 8443
sed -i '/443/a acl SSL_ports port 8443' /etc/squid/squid.conf

openvpn --config /data/config/vpnbook/$OVPN_FILENAME &
sleep 30
service squid start && \
echo "Success"
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
service networking restart

while true; do sleep 1000; done
