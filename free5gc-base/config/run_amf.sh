#!/bin/sh

if [ $# -ne 4 ]
  then
    echo "USE: ./run_amf.sh <MONGO_IP> <HSS_IP> <AMF_IP> <SMF_IP>"
    exit 1
fi

echo "Waiting for " ${MONGODB_STARTUP_TIME} "s for HSS to be ready..."
sleep ${MONGODB_STARTUP_TIME}

echo "Modifying configuration files..."
sed -i 's/mongodb_ip/'$1'/g' /etc/free5gc/amf.conf
sed -i 's/amf_ip/'$3'/g' /etc/free5gc/amf.conf
sed -i 's/smf_ip/'$4'/g' /etc/free5gc/amf.conf
sed -i 's/hss_ip/'$2'/g' /etc/free5gc/freeDiameter/amf.conf
sed -i 's/amf_ip/'$3'/g' /etc/free5gc/freeDiameter/amf.conf

echo "Configuring log file in: /var/log/free5gc/amf.log"
mkdir /var/log/free5gc
touch /var/log/free5gc/amf.log
tail -f /var/log/free5gc/amf.log &

echo "Launching AMF..."
./free5gc-amfd -f /etc/free5gc/amf.conf