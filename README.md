DESCRIPTION
-----------

This will start a openvpn client and start a squid proxy for that vpn
Vpn server to be use are from vpnbook.com

SETUP
-----

    Download and extract the file to config/vpnbook.
    vpn book website: https://www.vpnbook.com/#openvpn

BUILD
-----

    $ docker build .

RUN
---

    $ docker run \
        --env VPN_USER=vpnbook \
        --env VPN_PASS=he2qv5h \
        -p 3128:3128 \
        --device=/dev/net/tun \
        --cap-add=NET_ADMIN \
        -v $(pwd):/data \
        --rm -it 4c86246aabf2