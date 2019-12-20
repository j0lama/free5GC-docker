#!/bin/sh

MONGODB_STARTUP_TIME=5

echo "Will use ${DB_HOST} as database"

echo "Waiting for " ${MONGODB_STARTUP_TIME} "s for mongodb to be ready..."
sleep ${MONGODB_STARTUP_TIME}

mongoimport --host ${DB_HOST} --db free5gc --collection subscribers --file /tmp/imsi1.json --type json  --jsonArray

echo "Client 1 loaded in ${DB_HOST}"

sleep infinity