#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


DATE=`date +%Y%m%d%H%M%S`

. ./env.sh $*

PID=`ps -ef | grep java | grep "Djboss.management.native.port=$DOMAIN_MASTER_PORT" | grep "=$SERVER_NAME " | grep "Host Controller" | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "JBoss SERVER - $SERVER_NAME is already RUNNING..."
    exit;
fi

UNAME=`id -u -n`
if [ e$UNAME != "e$JBOSS_USER" ]
then
    echo "Use $JBOSS_USER account to start JBoss SERVER - $SERVER_NAME..."
    exit;
fi

echo $JAVA_OPTS

if [ ! -d "$JBOSS_LOG_DIR/nohup" ];
then
    mkdir -p $JBOSS_LOG_DIR/nohup
fi  

#mv $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out.$DATE
cp -a $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out.$DATE
cat /dev/null > $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out

nohup $JBOSS_HOME/bin/domain.sh -DSERVER=$SERVER_NAME -P=$DOMAIN_BASE/$SERVER_NAME/env.properties >> $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out 2>&1 &

if [ e$1 = "ewait" ]
then
# ex) ./start-instance.sh wait /session
    export CONTEXT_NAME=$2

    let HTTP_PORT=$DOMAIN_CONTROLLER_CONSOLE_PORT

    echo ""
    echo "Check $HTTP_PORT port ready on $BIND_ADDR "
    while [ `netstat -an | grep :$HTTP_PORT | grep LISTEN | wc | awk '{print $1}'` != 1 ]; do
            echo -ne "."
            sleep 1
    done

    echo ""
    echo "Check WAS Context Ready http://$BIND_ADDR:$HTTP_PORT$CONTEXT_NAME"

    until [ "`curl --silent --show-error --connect-timeout 1 -I http://$BIND_ADDR:$HTTP_PORT$CONTEXT_NAME | egrep '200|302|500|405'`" != "" ];
    do
            echo -ne "."
            sleep 1
    done
    echo ""

fi
