#!/usr/bin/env bash
#
# List Topics
#
ADMIN_PROPERTIES_PATH=/tmp/admin.properties
BOOTSTRAP_SERVER=localhost:29092

kafka-topics.sh --bootstrap-server ${BOOTSTRAP_SERVER} --list --command-config ${ADMIN_PROPERTIES_PATH}
