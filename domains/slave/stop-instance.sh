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

echo "$JBOSS_HOME/bin/jboss-cli.sh --connect $USERPASS --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command=/host=$HOST_NAME/server-config=$INSTANCE_NAME:stop"
$JBOSS_HOME/bin/jboss-cli.sh --connect $USERPASS --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command=/host=$HOST_NAME/server-config=$INSTANCE_NAME:stop

if [ e$1 = "ewait" ]
then
        # ex) ./stop-instance.sh wait / id pwd
        I=0
        until [ "`ps -eaf | grep java | grep $INSTANCE_NAME`" == "" ];
        do 
                if [ $I == 100 ]; then 
                        ps -ef | grep java | grep "$INSTANCE_NAME " | awk {'print "kill -9 " $2'} | sh -x
                        break;
                fi

                let I=$I+1 
    
                echo -ne "."
                sleep 1
        done 
fi  

