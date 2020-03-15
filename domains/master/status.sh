#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ./env.sh 

ps -ef | grep java | grep "Djboss.management.native.port=$DOMAIN_MASTER_PORT"  | grep "SERVER=$SERVER_NAME "
