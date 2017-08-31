#!/bin/bash

echo "saving vpn credentials"
rm /data/auth.txt
touch /data/auth.txt
VPN_PASSWORD=$(curl -sG https://www.vpnbook.com/\#openvpn | grep -m 1 Password | awk '{print $2}' | cut -f1 -d '<')
echo $VPN_USER >> /data/auth.txt
echo $VPN_PASSWORD >> /data/auth.txt
sed -i 's/auth-user-pass/auth-user-pass \/data\/auth.txt/g' /data/config/vpnbook/$OVPN_FILENAME

echo "Updating Squid Config"
sed -i '/acl localnet src 172.16.0.0\/12/s/^#//g' /etc/squid/squid.conf
sed -i '/http_access allow localnet/s/^#//g' /etc/squid/squid.conf
sed -i '/443/a acl SSL_ports port 8443' /etc/squid/squid.conf
openvpn --config /data/config/vpnbook/$OVPN_FILENAME &
sleep 30
service squid start && \
echo "Success"
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
service networking restart

while true; do sleep 1000; done
