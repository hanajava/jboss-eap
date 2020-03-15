#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh 

for count in 1 2 3 4 5; do
    echo "Thread Dump : $count"
    for i in `ps -ef | grep java | grep "Server:" | grep "SERVER=$SERVER_NAME " | awk '{print $2}'`;do
        date
        #echo "+kill -3 $i"
        echo "+jstack -l $i >> $JBOSS_LOG_DIR/nohup/thread_dump.$i"
        #kill -3 $i
        jstack -l $i >> $JBOSS_LOG_DIR/nohup/thread_dump.$i
        #echo "sleep 1 sec"
        #sleep 1
    done
    echo "done"
    sleep 3
done
