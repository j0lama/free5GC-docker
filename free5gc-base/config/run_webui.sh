#!/bin/sh

echo "Waiting for " ${MONGODB_STARTUP_TIME} "s for mongodb to be ready..."
sleep ${MONGODB_STARTUP_TIME}

echo "Launching webui..."
npm run start --prefix /free5gc/webui