DESCRIPTION
-----------

This will start a openvpn client and start a squid proxy for that vpn
Vpn server to be use are from vpnbook.com

SETUP
-----

    Download and extract the file to config/vpnbook.
    vpn book website: https://www.vpnbook.com/#openvpn

    The `ovpn` file should inside `config/vpnbook/` directory because this will be mounter in docker as `/data`.

BUILD (optional)
----------------

    $ docker build .

RUN
---

    $ docker run \
        --env OVPN_FILENAME=vpnbook-euro2-tcp443.ovpn \
        --env VPN_USER=vpnbook \
        --env VPN_PASS=he2qv5h \
        -p 3128:3128 \
        --device=/dev/net/tun \
        --cap-add=NET_ADMIN \
        -v $(pwd):/data \
        --rm -it ccfbb78ff9c8