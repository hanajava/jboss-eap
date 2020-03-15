#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh 

if [ e$1 = "ewait" ]
then
    for HTTPD_HOST in "${HTTPD_HOSTS[@]}" 
    do
        echo "<<< Turn-OFF Worker $WORKER in $LB_WORKER [$HTTPD_HOST]" 
        if [ "`curl --silent --show-error --connect-timeout 1 -I \"http://$HTTPD_HOST/jkstatus/?cmd=update&w=$LB_WORKER&sw=$WORKER&vwa=2\" | egrep '404|500|503'`" != "" ]
        then
            echo "<<< Error" 
        else
            echo "<<< Done" 
        fi
    done
    sleep 2
fi


echo "ps -ef | grep java | grep $HOST_NAME | grep "Djboss.management.native.port=$HOST_CONTROLLER_PORT" | grep "SERVER=$SERVER_NAME " | awk {'print "kill -9 " $2'} | sh -x"
ps -ef | grep java | grep $HOST_NAME | grep "Djboss.management.native.port=$HOST_CONTROLLER_PORT" | grep "SERVER=$SERVER_NAME " | awk {'print "kill -9 " $2'} | sh -x
