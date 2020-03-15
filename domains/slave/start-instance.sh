#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh

#export INSTANCE_NAME=user111
#export HOST_NAME=nwas01

export USERPASS="--user=wasadm --password=opennaru!2"
if [ "$#" -eq 4 ]; then
   export USERPASS="--user=$3 --password=$4"
fi

echo $JBOSS_HOME/bin/jboss-cli.sh --connect $USERPASS --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command=/host=$HOST_NAME/server-config=$INSTANCE_NAME:start
$JBOSS_HOME/bin/jboss-cli.sh --connect $USERPASS --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command=/host=$HOST_NAME/server-config=$INSTANCE_NAME:start


if [ e$1 = "ewait" ]
then
# ex) ./start-instance.sh wait /session
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

fi

