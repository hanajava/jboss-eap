#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ../env.sh

# -------------------------------------------------------------
#  CONNECTION POOL NAME 
# -------------------------------------------------------------
read -p "> Connection Pool 이름을 입력하십시오 : " DATASOURCE_NAME
read -p "> 설정할 Profile 이름을 입력하십시오(default,full,ha,full-ha) : " PROFILE_NAME

# -------------------------------------------------------------
#  MYSQL Data Source Example
#
#  jndi-name, connection-url, username, password은 접속 환경에 맞게
#    수정하여 사용하십시오.
# -------------------------------------------------------------
export MYSQL_DATASOURCE="
data-source --profile=$PROFILE_NAME add     \\
--name=$DATASOURCE_NAME                     \\
--jndi-name=java:jboss/datasources/abcDS    \\
--driver-name=mysql                         \\
--driver-class=com.mysql.jdbc.Driver        \\
--connection-url=jdbc:mysql://192.168.0.11:3306/test                \\
--min-pool-size=100                         \\
--max-pool-size=250                         \\
--pool-use-strict-min=true                  \\
--pool-prefill=true                         \\
--user-name=root                            \\
--password=passswd                          \\
--valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.mysql.MySQLValidConnectionChecker \\
--validate-on-match=false                   \\
--background-validation=true                \\
--background-validation-millis=10000        \\
--exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.mysql.MySQLExceptionSorter \\
--blocking-timeout-wait-millis=60000        \\
--idle-timeout-minutes=15                   \\
--track-statements=true                     \\
--prepared-statements-cache-size=300        \\
--share-prepared-statements=true"

# -------------------------------------------------------------
#  Oracle Data Source Example
#
#  jndi-name, connection-url, username, password은 접속 환경에 맞게
#    수정하여 사용하십시오.
# -------------------------------------------------------------
export ORACLE_DATASOURCE="
data-source --profile=$PROFILE_NAME add     \\
--name=$DATASOURCE_NAME                     \\
--jndi-name=java:jboss/datasources/abcdDS    \\
--driver-name=oracle                        \\
--driver-class=oracle.jdbc.OracleDriver     \\
--connection-url=jdbc:oracle:thin:@//192.168.0.11:1521/ORA           \\
--min-pool-size=100                         \\
--max-pool-size=250                         \\
--pool-use-strict-min=true                  \\
--pool-prefill=true                         \\
--user-name=root                            \\
--password=passswd                          \\
--valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.oracle.OracleValidConnectionChecker \\
--stale-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.oracle.OracleStaleConnectionChecker \\
--validate-on-match=false                   \\
--background-validation=true                \\
--background-validation-millis=10000        \\
--exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.oracle.OracleExceptionSorter \\
--blocking-timeout-wait-millis=60000        \\
--idle-timeout-minutes=15                   \\
--track-statements=true                     \\
--prepared-statements-cache-size=300        \\
--share-prepared-statements=true"



# 사용할 데이터 베이스를 선택하세요!!
# -------------------------------------------------------------
#  Data Source Select
# -------------------------------------------------------------
while true; do
    read -p "> 데이터베이스를 선택하십시오. oracle(o), mysql(m)? " db
    case $db in
        [Oo]* ) 
            export DATASOURCE=$ORACLE_DATASOURCE
            break;;
        [Mm]* ) 
            export DATASOURCE=$MYSQL_DATASOURCE
            break;;
        * ) echo "o 나 m 를 입력하십시오."; echo "";;
        
    esac
done

echo "-------------------------------------------------------------"
echo " 생성할 데이터소스 설정 정보 : "
echo "-------------------------------------------------------------"
echo "$DATASOURCE"
echo "-------------------------------------------------------------"

while true; do
    echo "* 데이터소스 설정을 변경하시려면 create-datasource.sh 스크립트 파일을 수정하십시오."
    read -p "> 위 설정으로 데이터 소스를 생성하시겠습니까(y/n)? " yn
    case $yn in
        [Yy]* ) 
            $JBOSS_HOME/bin/jboss-cli.sh --connect --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command="$DATASOURCE"
            $JBOSS_HOME/bin/jboss-cli.sh --connect --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command="data-source --profile=$PROFILE_NAME enable --name=$DATASOURCE_NAME"
            break;;
        [Nn]* ) exit;;
        * ) echo "y 나 n 를 입력하십시오."; echo "";;
        
    esac
done
    
