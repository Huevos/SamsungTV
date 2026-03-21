#!/bin/sh
rm -f /etc/opkg/cockpit-feed.conf
opkg update
echo src/gz cockpit-all https://OpenCockpit.github.io/Cockpit-Feed/packages/ > /etc/opkg/cockpit-feed-.conf
opkg update
opkg install 
init 2
init 3
