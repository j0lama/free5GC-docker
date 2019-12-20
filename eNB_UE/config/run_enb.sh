#!/bin/sh
if [ $# -ne 2 ]
  then
    echo "USE: ./run_enb.sh <AMF_IP> <ENB_IP>"
    exit 1
fi

sed -i 's/CI_MME_IP_ADDR/'$1'/g' eNB.conf
sed -i 's/CI_ENB_IP_ADDR/'$2'/g' eNB.conf

source ../../../oaienv
ENODEB=1 ./lte-softmodem -O eNB.conf --basicsim