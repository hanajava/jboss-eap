#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh $*

JBOSS_MODULEPATH="$JBOSS_HOME/modules/system/layers/base"

MODULES="org/jgroups"

for MODULE in $MODULES
do
    for JAR in `cd "$JBOSS_MODULEPATH/$MODULE/main/" && ls -1 *.jar`
    do
        CLASSPATH="$CLASSPATH:$JBOSS_MODULEPATH/$MODULE/main/$JAR"
    done
done

export CLASSPATH



PID=`ps -ef | grep java | grep "=GOSSIP_ROUTER " | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "JBoss GOSSIP_ROUTER - is already RUNNING..."
    exit;
fi

nohup java -classpath $CLASSPATH -Dname=GOSSIP_ROUTER org.jgroups.stack.GossipRouter -port 12001 >> gossip.out &