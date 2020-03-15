#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.2.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


CURRENT_DIR=`pwd`

for JAR in `cd "$CURRENT_DIR/lib/" && ls -1 *.jar`
do
    CLASSPATH="$CLASSPATH:$CURRENT_DIR/lib/$JAR"
done

#echo CLASSPATH $CLASSPATH
export CLASSPATH

java ${JAVA_OPTS} com.opennaru.khan.monitoring.StandaloneMonitoring $*


