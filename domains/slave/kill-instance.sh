#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh

export INSTANCE_NAME=user111

ps -ef | grep java | grep "\-D\[Server:$INSTANCE_NAME\] " | awk {'print "kill -9 " $2'} | sh -x
