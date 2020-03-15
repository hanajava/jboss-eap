#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# ------------------------------------------------------------- 

. ../env.sh

# 도메인 컨트롤러 IP와 포트
export HOST=$DOMAIN_MASTER_ADDR
export PORT=$DOMAIN_MASTER_PORT

# 도메인 컨트롤러 접속 계정
export USERNAME="wasadm"
export PASSWORD="opennaru!2"

# 체크 주기(초)
export INTERVAL=30

PID=`ps -ef | grep java | grep "DJBOSS_DOMAIN_MONITORING_${HOST}_${PORT}" | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "JBOSS_DOMAIN_MONITORING is already RUNNING..."
    exit;
fi

export JAVA_OPTS="-DJBOSS_DOMAIN_MONITORING_${HOST}_${PORT}"

nohup ./domain_mon.sh -host=${HOST} -port=${PORT} -username=${USERNAME} -password=${PASSWORD} -interval=${INTERVAL} >> log/monitoring-domain-${HOST}-${PORT}.log 2>&1 & 

