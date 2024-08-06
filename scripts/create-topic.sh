#!/usr/bin/env bash
#
# Create a topic
#
TOPIC=${1:?<define topic name>}

BOOTSTRAP_SERVER=localhost:29092
ADMIN_PROPERTIES_PATH=/tmp/admin.properties

kafka-topics.sh --bootstrap-server ${BOOTSTRAP_SERVER} \
  --create --topic ${TOPIC} \
  --partitions 3 --replication-factor 3 \
  --command-config ${ADMIN_PROPERTIES_PATH}
