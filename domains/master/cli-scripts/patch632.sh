#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss EAP 6.3.0
#
#   contact : service@opennaru.com
#   Copyright(C) 2013, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

. ../env.sh

echo "domain mode patch is not working!"
echo "use standalone.sh and jboss-cli.sh to apply patch on each machine."
echo "patch apply --override-all /svc/was/user1/upload/jboss-eap-6.3.2-patch.zip"

#$JBOSS_HOME/bin/jboss-cli.sh --connect --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command="patch apply --host=master --override-all /svc/was/user1/upload/jboss-eap-6.3.2-patch.zip"

#$JBOSS_HOME/bin/jboss-cli.sh --connect --controller=$DOMAIN_MASTER_ADDR:$DOMAIN_MASTER_PORT --command="patch apply --host=nwas01 --override-all /svc/was/user1/upload/jboss-eap-6.3.2-patch.zip"
