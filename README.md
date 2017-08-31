DESCRIPTION
-----------

This will start a openvpn client and start a squid proxy for that vpn
Vpn server.

Vpn server was vpnbook.com.

You can use this if you want to access websites that is block in your firewall

Tested in OSX 10.12.x

SETUP and RUN
-------------

1. Create a new folder

    $ mkdir vpn_docker

2. Run the docker

    $ docker run \
        --env OVPN_FILENAME=vpnbook-euro2-tcp443.ovpn \
        --env VPN_USER=vpnbook \
        -p 3128:3128 \
        --device=/dev/net/tun \
        --cap-add=NET_ADMIN \
        -v $(pwd):/data \
        --rm -it junejie/openvpn-squid:latest


3. The `ovpn` file should inside `config/vpnbook/` directory because this will be mounter in docker as `/data`.

4. After successful run. Open your browser and configure your proxy to `localhost` and port `3128`.

Note: pvn password will be pulled automatically

![browser](https://raw.githubusercontent.com/junejie/junejie-openvpn-squid/master/images/screenshot-1.png)
