#!/usr/bin/env bash
#
# Remove Kafka users
#
BOOTSTRAP_SERVER=localhost:29092
ADMIN_PROPERTIES_PATH=/tmp/admin.properties

shopt -s expand_aliases
alias kafka-configs="kafka-configs.sh"

kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --alter --delete-config "SCRAM-SHA-256" \
  --entity-type users --entity-name user1 \
  --command-config ${ADMIN_PROPERTIES_PATH}

kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --alter --delete-config "SCRAM-SHA-512" \
  --entity-type users --entity-name user1 \
  --command-config ${ADMIN_PROPERTIES_PATH}

kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --alter --delete-config "SCRAM-SHA-256" \
  --entity-type users --entity-name user2 \
  --command-config ${ADMIN_PROPERTIES_PATH}

kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --alter --delete-config "SCRAM-SHA-512" \
  --entity-type users --entity-name user2 \
  --command-config ${ADMIN_PROPERTIES_PATH}
