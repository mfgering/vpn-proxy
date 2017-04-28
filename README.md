vpn-proxy
=========

This image contains a SOCKS server ([dante](http://www.inet.no/dante/index.html)) and a VPN client ([openvpn](https://openvpn.net/)).

The motivation is to provide web browsing privacy in an environment where other applications don't need or want to use a VPN. For example, configure a browser, e.g. portable Firefox,  to use the SOCKS proxy in front of a VPN in a home environment. 