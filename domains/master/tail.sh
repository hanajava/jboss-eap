#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh 

#tail -f $JBOSS_LOG_DIR/host-controller.log
tail -f $JBOSS_LOG_DIR/nohup/master.out
