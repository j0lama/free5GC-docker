#!/bin/sh
if [ $# -ne 2 ]
  then
    echo "USE: ./run_enb.sh <AMF_IP> <ENB_IP>"
    exit 1
fi
sleep 7
srsenb /config/enb.conf.fauxrf --enb.name=dummyENB01 --enb.mcc=208 --enb.mnc=93 --enb.enb_id=18AF1 --enb.tac=0x0001 --enb.cell_id=01 --enb.mme_addr=$1 --enb.gtp_bind_addr=$2 --enb.s1c_bind_addr=$2 --enb_files.rr_config=/config/rr.conf --enb_files.sib_config=/config/sib.conf --enb_files.drb_config=/config/drb.conf