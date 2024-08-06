#!/usr/bin/env bash
#
# Create ACLs
#
BOOTSTRAP_SERVER=localhost:29092
ADMIN_PROPERTIES_PATH=/tmp/admin.properties

shopt -s expand_aliases
alias kafka-acls="kafka-acls.sh"

# Reject permissions for user1
kafka-acls --bootstrap-server ${BOOTSTRAP_SERVER} \
  --add --deny-principal User:user1 --operation All --topic some_test_topic \
  --command-config ${ADMIN_PROPERTIES_PATH}
