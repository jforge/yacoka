#!/usr/bin/env bash
#
# Lists ACLs
#
BOOTSTRAP_SERVER=localhost:29092
ADMIN_PROPERTIES_PATH=/tmp/admin.properties

shopt -s expand_aliases
alias kafka-acls="kafka-acls.sh"

# Grant permissions to user1 to produce and consume from a specific topic
kafka-acls --bootstrap-server ${BOOTSTRAP_SERVER} \
  --list \
  --command-config ${ADMIN_PROPERTIES_PATH}
