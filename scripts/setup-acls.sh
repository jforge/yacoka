#!/usr/bin/env bash
#
# Create ACLs
#
BOOTSTRAP_SERVER=localhost:29092
ADMIN_PROPERTIES_PATH=/tmp/admin.properties

shopt -s expand_aliases
alias kafka-acls="kafka-acls.sh"

# Grant essential permission to work with Connectware
kafka-acls --bootstrap-server ${BOOTSTRAP_SERVER} \
  --add --allow-principal User:user1 --operation Describe --group '*' \
  --command-config ${ADMIN_PROPERTIES_PATH}

kafka-acls --bootstrap-server ${BOOTSTRAP_SERVER} \
  --add --allow-principal User:user1 --operation Read --group '*' \
  --command-config ${ADMIN_PROPERTIES_PATH}


# Grant permissions to user1 to produce and consume from a specific topic
kafka-acls --bootstrap-server ${BOOTSTRAP_SERVER} \
  --add --allow-principal User:user1 --operation All --topic some_test_topic \
  --command-config ${ADMIN_PROPERTIES_PATH}

# Restrict user1 from producing to restricted-topic
kafka-acls --bootstrap-server ${BOOTSTRAP_SERVER} \
  --add --deny-principal User:user1 --operation Write --topic restricted \
  --command-config ${ADMIN_PROPERTIES_PATH}

# Grant permissions to user2 to consume from a specific group
kafka-acls --bootstrap-server ${BOOTSTRAP_SERVER} \
  --add --allow-principal User:user2 --operation Read --group my-group \
  --command-config ${ADMIN_PROPERTIES_PATH}

# Add ACLs for specific topics in a Connectware use case
kafka-acls --bootstrap-server ${BOOTSTRAP_SERVER} \
  --add --allow-principal User:user1 --operation All \
  --topic SYS. --resource-pattern-type prefixed \
  --command-config ${ADMIN_PROPERTIES_PATH}
