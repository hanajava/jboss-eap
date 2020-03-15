#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh 

ps -ef | grep java | grep user1 | grep "Djboss.management.native.port=$HOST_CONTROLLER_PORT" | grep "SERVER=$SERVER_NAME "
