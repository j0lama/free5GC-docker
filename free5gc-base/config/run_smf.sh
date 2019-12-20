#!/bin/sh

if [ $# -ne 3 ]
  then
    echo "USE: ./run_smf.sh <SMF_IP> <UPF_IP> <PCRF_IP>"
    exit 1
fi

echo "Waiting for " ${MONGODB_STARTUP_TIME} "s for AMF to be ready..."
sleep ${MONGODB_STARTUP_TIME}


echo "Modifying configuration files..."
sed -i 's/smf_ip/'$1'/g' /etc/free5gc/smf.conf
sed -i 's/upf_ip/'$2'/g' /etc/free5gc/smf.conf
#sed -i '/ue_pool/i #AMF ip\n    http:\n      addr: '$1'\n      port: 8080' /etc/free5gc/smf.conf
sed -i 's/smf_ip/'$1'/g' /etc/free5gc/freeDiameter/smf.conf
sed -i 's/pcrf_ip/'$3'/g' /etc/free5gc/freeDiameter/smf.conf

echo "Configuring log file in: /var/log/free5gc/smf.log"
mkdir /var/log/free5gc
touch /var/log/free5gc/smf.log
tail -f /var/log/free5gc/smf.log &

echo "Launching SMF..."
./free5gc-smfd -f /etc/free5gc/smf.conf