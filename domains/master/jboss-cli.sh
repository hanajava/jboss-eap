#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ./env.sh 

export JAVA_OPTS=" $JAVA_OPTS -Djava.awt.headless=false "

echo "$JBOSS_HOME/bin/jboss-cli.sh  --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --connect $@"
$JBOSS_HOME/bin/jboss-cli.sh  --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --connect $@
