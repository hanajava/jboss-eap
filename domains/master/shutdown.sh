#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh 

echo "$JBOSS_HOME/bin/jboss-cli.sh --connect --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command=/host=master:shutdown"
$JBOSS_HOME/bin/jboss-cli.sh --connect --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command=/host=master:shutdown
