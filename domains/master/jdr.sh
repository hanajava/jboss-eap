#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ./env.sh 

$JBOSS_HOME/bin/jdr.sh $@

tar cvfz khan_sosreport_$DATE.tar.gz configuration/ $JBOSS_LOG_DIR/ *.sh *.properties