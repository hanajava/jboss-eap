#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ../env.sh

export PROFILE_NAME=default
export CHECK_INTERVAL=1

echo ""
echo ">>> /profile=$PROFILE_NAME/subsystem=web/configuration=jsp-configuration/:write-attribute(name=development,value=true)"
$JBOSS_HOME/bin/jboss-cli.sh --connect --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command="/profile=$PROFILE_NAME/subsystem=web/configuration=jsp-configuration/:write-attribute(name=development,value=true)"

echo ""
echo ">>> /profile=$PROFILE_NAME/subsystem=web/configuration=jsp-configuration/:write-attribute(name=check-interval,value=$CHECK_INTERVAL)"
$JBOSS_HOME/bin/jboss-cli.sh --connect --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command="/profile=$PROFILE_NAME/subsystem=web/configuration=jsp-configuration/:write-attribute(name=check-interval,value=$CHECK_INTERVAL)"

