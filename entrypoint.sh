#!/bin/bash

echo "Downloading vpn config"
mkdir -p /data/config/vpnbook
cd /data/config/vpnbook
curl https://www.vpnbook.com/free-openvpn-account/VPNBook.com-OpenVPN-Euro2.zip -o vpn.zip
unzip -o vpn.zip

echo "Saving vpn credentials"
VPN_PASSWORD=$(curl -sG https://www.vpnbook.com/\#openvpn | grep -m 1 Password | awk '{print $2}' | cut -f1 -d '<')
touch /data/auth.txt
echo vpnbook > /data/auth.txt
echo $VPN_PASSWORD >> /data/auth.txt
sed -i 's/auth-user-pass/auth-user-pass \/data\/auth.txt/g' /data/config/vpnbook/vpnbook-euro2-tcp443.ovpn

echo "Updating Squid Config"
sed -i '/acl localnet src 172.16.0.0\/12/s/^#//g' /etc/squid/squid.conf
sed -i '/http_access allow localnet/s/^#//g' /etc/squid/squid.conf
sed -i '/443/a acl SSL_ports port 8443' /etc/squid/squid.conf

echo "Starting vpn client"
openvpn --config /data/config/vpnbook/vpnbook-euro2-tcp443.ovpn &
sleep 30

echo "Starting squid server"
service squid start && \
echo "Squid server is running"

echo "Setting up dns"
echo 'nameserver 8.8.8.8' > /etc/resolv.conf

echo "Restarting network"
service networking restart && \
echo " -----------------------------------------"
echo "| You can now use localhost:3128 as proxy |"
echo " -----------------------------------------"

while true; do sleep 1000; done
