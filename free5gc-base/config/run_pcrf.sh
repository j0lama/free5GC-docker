#!/bin/sh

if [ $# -ne 3 ]
  then
    echo "USE: ./run_pcrf.sh <MONGO_IP> <SMF_IP> <PCRF_IP>"
    exit 1
fi



echo "Modifying configuration files..."
sed -i 's/mongodb_ip/'$1'/g' /etc/free5gc/pcrf.conf
sed -i 's/pcrf_ip/'$3'/g' /etc/free5gc/freeDiameter/pcrf.conf
sed -i 's/smf_ip/'$2'/g' /etc/free5gc/freeDiameter/pcrf.conf

echo "Configuring log file in: /var/log/free5gc/pcrf.log"
mkdir /var/log/free5gc
touch /var/log/free5gc/pcrf.log
tail -f /var/log/free5gc/pcrf.log &

echo "Launching PCRF..."
#sleep infinity
./nextepc-pcrfd -f /etc/free5gc/pcrf.conf