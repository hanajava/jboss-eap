#!/bin/sh

DATE=`date +%Y%m%d%H%M%S`

. ./env.sh $*



if [ e$1 = "estop" ]
then
    for HTTPD_HOST in "${HTTPD_HOSTS[@]}"
    do
        echo "<<< Turn-OFF Worker $WORKER in $LB_WORKER [$HTTPD_HOST]" 
        if [ "`curl --silent --show-error --connect-timeout 1 -I \"http://$HTTPD_HOST/jkstatus/?cmd=update&w=$LB_WORKER&sw=$WORKER&vwa=2\" | egrep '404|403|500|503'`" != "" ]
        then
            echo "<<< Error" 
        else
            echo "<<< Done" 
        fi
    done
fi


if [ e$1 = "estart" ]
then
# ex) ./start.sh wait /session

    for HTTPD_HOST in "${HTTPD_HOSTS[@]}"
    do
        echo "<<< Turn-ON Worker $WORKER in $LB_WORKER [$HTTPD_HOST]" 
        if [ "`curl --silent --show-error --connect-timeout 1 -I \"http://$HTTPD_HOST/jkstatus/?cmd=update&w=$LB_WORKER&sw=$WORKER&vwa=0\" | egrep '404|403|500|503'`" != "" ]
        then
            echo "<<< Error" 
        else
            echo "<<< Done" 
        fi
    done

fi
