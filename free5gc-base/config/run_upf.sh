#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "USE: ./run_upf.sh <UPF_IP>"
    exit 1
fi

echo "Configuring the network"
ip tuntap add name uptun mode tun
ip addr del 45.45.0.1/16 dev uptun 2> /dev/null
ip addr add 45.45.0.1/16 dev uptun
ip addr del cafe::1/64 dev uptun 2> /dev/null
ip addr add cafe::1/64 dev uptun
ip link set uptun up
# masquerade
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -I INPUT -i uptun -j ACCEPT
sysctl -w net.ipv6.conf.all.disable_ipv6=0

echo "Waiting for " ${MONGODB_STARTUP_TIME} "s for PCRF to be ready..."
sleep ${MONGODB_STARTUP_TIME}
sleep ${MONGODB_STARTUP_TIME}


echo "Modifying configuration files..."
sed -i 's/upf_ip/'$1'/g' /etc/free5gc/upf.conf

echo "Configuring log file in: /var/log/free5gc/upf.log"
mkdir /var/log/free5gc
touch /var/log/free5gc/upf.log
tail -f /var/log/free5gc/upf.log &

echo "Launching UPF..."
./free5gc-upfd -f /etc/free5gc/upf.conf