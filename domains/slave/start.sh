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

PID=`ps -ef | grep java | grep user1 | grep "Djboss.management.native.port=$HOST_CONTROLLER_PORT" | grep "=$SERVER_NAME " | grep "Host Controller" | awk '{print $2}'`
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

rm -rf servers/user111/tmp/*

export JAVA_OPTS="$AGENT_OPTS $JAVA_OPTS"


if [ e$1 = "ewait" ]
then
    for HTTPD_HOST in "${HTTPD_HOSTS[@]}"
    do
        echo "<<< Turn-OFF Worker $WORKER in $LB_WORKER [$HTTPD_HOST]"
        if [ "`curl --silent --show-error --connect-timeout 1 -I \"http://$HTTPD_HOST/jkstatus/?cmd=update&w=$LB_WORKER&sw=$WORKER&vwa=1\" | egrep '404|500|503'`" != "" ]
        then
            echo "<<< Error"
        else
            echo "<<< Done"
        fi
    done
fi

nohup $JBOSS_HOME/bin/domain.sh -DSERVER=$SERVER_NAME -P=$DOMAIN_BASE/$SERVER_NAME/env.properties -b 0.0.0.0 --backup >> $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out 2>&1 &
#nohup $JBOSS_HOME/bin/domain.sh -DSERVER=$SERVER_NAME -P=$DOMAIN_BASE/$SERVER_NAME/env.properties -b 0.0.0.0 --cached-dc >> $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out 2>&1 &


if [ e$1 = "etail" ]
then
    tail -f $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out
fi

if [ e$1 = "ewait" ]
then
# ex) ./start.sh wait /session
    export CONTEXT_NAME=$2

    let HTTP_PORT=8080+100

    echo ""
    echo "Check $HTTP_PORT port ready on $BIND_ADDR "
    while [ `netstat -an | grep :$HTTP_PORT | grep LISTEN | wc | awk '{print $1}'` != 1 ]; do
            echo -ne "."
            sleep 1
    done

    echo ""
    echo "Check WAS Context Ready http://$BIND_ADDR:$HTTP_PORT$CONTEXT_NAME"

    until [ "`curl --silent --show-error --connect-timeout 1 -I http://$BIND_ADDR:$HTTP_PORT$CONTEXT_NAME | egrep '200|302|500'`" != "" ];
    do
            echo -ne "."
            sleep 1
    done
    echo ""

    for HTTPD_HOST in "${HTTPD_HOSTS[@]}"
    do
        export WORKER=user111
        echo "<<< Turn-ON Worker $WORKER in $LB_WORKER [$HTTPD_HOST]"
        if [ "`curl --silent --show-error --connect-timeout 1 -I \"http://$HTTPD_HOST/jkstatus/?cmd=update&w=$LB_WORKER&sw=$WORKER&vwa=0\" | egrep '404|500|503'`" != "" ]
        then
            echo "<<< Error"
        else
            echo "<<< Done"
        fi
    done

fi


