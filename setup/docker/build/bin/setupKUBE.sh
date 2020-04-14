#!/bin/bash

set -e

if [[ $# -eq 1 ]]
then

    MICROSERVICE=${1}
    echo "MICROSERVICE :::>>> ${MICROSERVICE}"

else
    echo "Usage: . ./setupKUBE.sh <<MICROSERVICE>>"
    exit 1
fi

# KUBE Microservice running as Docker Container
# --------------------------------------------
# https://localhost:20024/kube/customers/info/index.html

echo "PWD ::: ${PWD}"
ls -al ${PWD}

./bin/setupKUBEUser.sh

chown kubeadmin:kubeadmin -R /opt/mw/apps/kube/

./bin/setupKUBERuntime.sh ${MICROSERVICE}

chmod 775 -R /opt/mw/

echo "ls -R /opt/ ---"
ls -alR /opt/
