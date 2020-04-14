#!/bin/bash

set -e

if [[ $# -eq 1 ]]
then

    MICROSERVICE=${1}
    echo "MICROSERVICE :::>>> ${MICROSERVICE}"

else
    echo "Usage: . ./setupKUBERuntime.sh <<MICROSERVICE>>"
    exit 1
fi

echo "###Setup KUBE Runtime Environment###"

mkdir -p /opt/mw/apps/kube/${MICROSERVICE}/

kubeBase=${MICROSERVICE:0:3}
echo "$MICROSERVICE :::>>> Evaluated kubeBase <<<${kubeBase}>>>"

mkdir -p /opt/mw/mount/logs/${kubeBase}/${MICROSERVICE}/

mv ${MICROSERVICE}*.jar /opt/mw/apps/kube/${MICROSERVICE}/

chown kubeadmin:kubeadmin -R /opt/mw/

chmod 775 -R /opt/mw/

ls -R /opt/mw/
