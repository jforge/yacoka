#!/usr/bin/env bash
#
# Create Kafka users
#
BOOTSTRAP_SERVER=localhost:29092
ADMIN_PROPERTIES_PATH=/tmp/admin.properties

shopt -s expand_aliases
alias kafka-configs="kafka-configs.sh"

# User 1
kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --alter --add-config 'SCRAM-SHA-256=[password=password123]' \
  --entity-type users --entity-name user1 \
  --command-config ${ADMIN_PROPERTIES_PATH}

kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --alter --add-config 'SCRAM-SHA-512=[password=password123]' \
  --entity-type users --entity-name user1 \
  --command-config ${ADMIN_PROPERTIES_PATH}

# User 2
kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --alter --add-config 'SCRAM-SHA-256=[password=password123]' \
  --entity-type users --entity-name user2 \
  --command-config ${ADMIN_PROPERTIES_PATH}

kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --alter --add-config 'SCRAM-SHA-512=[password=password123]' \
  --entity-type users --entity-name user2 \
  --command-config ${ADMIN_PROPERTIES_PATH}
