#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ./env.sh 

echo "======================================================="
echo " JMX URL : service:jmx:remoting-jmx://$MGMT_ADDR:4447 (+OFFSET)"
echo "======================================================="


JBOSS_MODULEPATH="$JBOSS_HOME/modules/system/layers/base"

CLASSPATH=
CLASSPATH=$JAVA_HOME/lib/jconsole.jar
CLASSPATH=$CLASSPATH:$JAVA_HOME/lib/tools.jar

MODULES="org/jboss/remoting-jmx org/jboss/remoting3 org/jboss/logging org/jboss/xnio org/jboss/xnio/nio org/jboss/sasl org/jboss/marshalling org/jboss/marshalling/river org/jboss/staxmapper org/jboss/as/protocol org/jboss/dmr org/jboss/as/controller-client org/jboss/threads org/jboss/as/controller"

for MODULE in $MODULES
do
    for JAR in `cd "$JBOSS_MODULEPATH/$MODULE/main/" && ls -1 *.jar`
    do
        CLASSPATH="$CLASSPATH:$JBOSS_MODULEPATH/$MODULE/main/$JAR"
    done
done


#echo CLASSPATH $CLASSPATH

jconsole -J-Djava.class.path="$CLASSPATH"

#$JBOSS_HOME/bin/jconsole.sh
