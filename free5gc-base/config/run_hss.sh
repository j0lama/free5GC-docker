#!/bin/sh

#!/bin/sh

if [ $# -ne 3 ]
  then
    echo "USE: ./run_hss.sh <MONGO_IP> <HSS_IP> <AMF_IP>"
    exit 1
fi

echo "Waiting for " ${MONGODB_STARTUP_TIME} "s for mongodb to be ready..."
sleep ${MONGODB_STARTUP_TIME}

echo "Modifying configuration files..."
sed -i 's/mongodb_ip/'$1'/g' /etc/free5gc/hss.conf
sed -i 's/hss_ip/'$2'/g' /etc/free5gc/freeDiameter/hss.conf
sed -i 's/amf_ip/'$3'/g' /etc/free5gc/freeDiameter/hss.conf

echo "Configuring log file in: /var/log/free5gc/hss.log"

mkdir /var/log/free5gc
touch /var/log/free5gc/hss.log
tail -f /var/log/free5gc/hss.log &

echo "Launching HSS..."
./nextepc-hssd -f /etc/free5gc/hss.conf