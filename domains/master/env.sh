#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

DATE=`date +%Y%m%d_%H%M%S`

##### JBOSS Directory Setup #####
export JBOSS_HOME=/svc/jboss/jboss-eap-6.3
export DOMAIN_BASE=/svc/was/user1/domains
export SERVER_NAME=master
export DOMAIN_BASE_DIR=$DOMAIN_BASE/$SERVER_NAME
export JBOSS_BASE_DIR="$DOMAIN_BASE_DIR"
export JBOSS_LOG_DIR=$DOMAIN_BASE/$SERVER_NAME/logs

#if [ e$JBOSS_LOG_DIR = "e" ]
#then
#export JBOSS_LOG_DIR="$JBOSS_HOME/log"
#fi

#if [ e$JBOSS_LOG_DIR != "e" ]
#then
#export JBOSS_LOG_DIR="$DOMAIN_BASE/$SERVER_NAME/logs"
#fi

##### Configration File #####
export DOMAIN_CONFIG_FILE=domain.xml
export HOST_CONFIG_FILE=host-master.xml

export HOST_NAME=was01
export NODE_NAME=$HOST_NAME
export JBOSS_USER=jboss

##### Domain Address #####
export DOMAIN_MASTER_ADDR=192.168.110.141
export DOMAIN_MASTER_PORT=9999
export DOMAIN_CONTROLLER_CONSOLE_PORT=9990

##### Bind Address #####
export BIND_ADDR=192.168.110.141
export MGMT_ADDR=192.168.110.141
export HOST_CONTROLLER_PORT=9999

##### Multicast Address #####
#export MULTICAST_ADDR=224.0.0.11
#export MULTICAST_PORT=55200
#export JMS_MULTICAST_ADDR=231.71.1.1
#export MODCLUSTER_MULTICAST_ADDR=224.11.1.105

export LAUNCH_JBOSS_IN_BACKGROUND=true

##### JBoss System module and User module directory #####
export JBOSS_MODULEPATH=$JBOSS_HOME/modules

# JVM Options : Server
#export JAVA_OPTS="-server $JAVA_OPTS"

# JVM Options : Memory
#export JAVA_OPTS=" $JAVA_OPTS -Xms128m -Xmx256m -XX:PermSize=64m -XX:MaxPermSize=128m -Xss256k"
export JAVA_OPTS=" $JAVA_OPTS -Xms128m -Xmx256m -Xss256k"

#export JAVA_OPTS=" $JAVA_OPTS -verbose:gc"
#export JAVA_OPTS=" $JAVA_OPTS -Xloggc:logs/gc_$DATE.log "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+PrintGCTimeStamps "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+PrintGCDetails "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseParallelGC "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseParallelOldGC "

#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseConcMarkSweepGC "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseG1GC "

#export JAVA_OPTS=" $JAVA_OPTS -XX:+ExplicitGCInvokesConcurrent "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError "
#export JAVA_OPTS=" $JAVA_OPTS -XX:HeapDumpPath=logs/heapdump "

# Linux Large Page Setting
#export JAVA_OPTS=" $JAVA_OPTS  -XX:+UseLargePages "
#export JAVA_OPTS=" $JAVA_OPTS  -XX:LargePageSizeInBytes=2m "

export JAVA_OPTS=" $JAVA_OPTS -Djava.net.preferIPv4Stack=true"
#export JAVA_OPTS=" $JAVA_OPTS -Dorg.jboss.resolver.warning=true"
#export JAVA_OPTS=" $JAVA_OPTS -Dsun.rmi.dgc.client.gcInterval=0x7FFFFFFFFFFFFFFE"
#export JAVA_OPTS=" $JAVA_OPTS -Dsun.rmi.dgc.server.gcInterval=0x7FFFFFFFFFFFFFFE"
#export JAVA_OPTS=" $JAVA_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman,com.opennaru.khan.agent,org.github.jamm"
#export JAVA_OPTS=" $JAVA_OPTS -Djava.awt.headless=true"

#export JAVA_OPTS=" $JAVA_OPTS -DDATE=$DATE"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.domain.default.config=$DOMAIN_CONFIG_FILE"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.host.default.config=$HOST_CONFIG_FILE"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.domain.base.dir=$DOMAIN_BASE_DIR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.domain.log.dir=$JBOSS_LOG_DIR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.domain.master.address=$DOMAIN_MASTER_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.domain.master.port=$DOMAIN_MASTER_PORT"

export JAVA_OPTS=" $JAVA_OPTS -Djboss.node.name=$NODE_NAME"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.bind.address=$BIND_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.bind.address.management=$MGMT_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.management.native.port=$DOMAIN_MASTER_PORT"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.management.http.port=$DOMAIN_CONTROLLER_CONSOLE_PORT"

#export JAVA_OPTS=" $JAVA_OPTS -Djboss.default.multicast.address=$MULTICAST_ADDR"
#export JAVA_OPTS=" $JAVA_OPTS -Djboss.default.multicast.port=$MULTICAST_PORT"
#export JAVA_OPTS=" $JAVA_OPTS -Djboss.messaging.group.address=$JMS_MULTICAST_ADDR"
#export JAVA_OPTS=" $JAVA_OPTS -Djboss.modcluster.multicast.address=$MODCLUSTER_MULTICAST_ADDR"


# jgroups stack
# udp, tcp, tcp-fileping, tcp-gossip
#export JAVA_OPTS=" $JAVA_OPTS -Djboss.default.jgroups.stack=udp "
#export JAVA_OPTS=" $JAVA_OPTS -Djgroups.tcpping.initial_hosts=192.168.110.141[7700],192.168.110.142[7700],192.168.110.13[7700],192.168.110.14[7700], "
#export JAVA_OPTS=" $JAVA_OPTS -Djgroups.fileping.location=/share/data/fileping "
#export JAVA_OPTS=" $JAVA_OPTS -Djgroups.tcpgossip.hosts=192.168.110.141[12001],192.168.110.142[12001],192.168.110.13[12001],192.168.110.14[12001] "

# Use log4j in application
#export JAVA_OPTS=" $JAVA_OPTS -Dorg.jboss.as.logging.per-deployment=false "

echo "============================================================="
echo "   KHAN [provisioning]               http://www.opennaru.com "
echo "   JBoss EAP 6.3.0                      service@opennaru.com "
echo "-------------------------------------------------------------"
echo "JBOSS_HOME=$JBOSS_HOME"
echo "DOMAIN_BASE=$DOMAIN_BASE"
echo "SERVER_NAME=$SERVER_NAME"
echo "DOMAIN_CONFIG_FILE=$DOMAIN_CONFIG_FILE"
echo "HOST_CONFIG_FILE=$HOST_CONFIG_FILE"
echo "DOMAIN_CONTROLLER=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT"
echo "CONSOLE=http://$DOMAIN_MASTER_ADDR:$DOMAIN_CONTROLLER_CONSOLE_PORT"
echo "============================================================="
