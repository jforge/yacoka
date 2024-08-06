#!/usr/bin/env bash
#
# Describe Kafka users
#
BOOTSTRAP_SERVER=localhost:29092
ADMIN_PROPERTIES_PATH=/tmp/admin.properties

shopt -s expand_aliases
alias kafka-configs="kafka-configs.sh"

kafka-configs --bootstrap-server ${BOOTSTRAP_SERVER} \
  --describe --entity-type users \
  --command-config ${ADMIN_PROPERTIES_PATH}
