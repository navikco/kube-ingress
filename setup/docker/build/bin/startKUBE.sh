#!/bin/bash

set -e

echo "CURRENT DIRECTORY :::>>> ${PWD}"

echo "Docker KUBE Container Args :::>>> $@"

echo "Which Java???"
which java

echo "Java Version???"
java -version

if [[ $# -eq 4 ]]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

    MICROSERVICE=${2}
    echo "MICROSERVICE :::>>> ${MICROSERVICE}"

    KUBE_ADMIN_HOST=$3
    echo ${KUBE_ADMIN_HOST}

    KUBE_ADMIN_PORT=$4
    echo ${KUBE_ADMIN_PORT}

else
    echo "Usage: . ./startKUBE.sh <<ENVIRONMENT>> <<MICROSERVICE>> <<KUBE_ADMIN_HOST>> <<KUBE_ADMIN_PORT>>"
    exit 1
fi

INSTANCE=$HOSTNAME

KUBE_HOME=/opt/mw/apps/kube/

cd ${KUBE_HOME}

echo "$MICROSERVICE :::>>> FileSystem Validation!!!"
ls -R /opt/mw/

ls -al /opt/mw/

echo "STARTING :::>>> KUBE Microservice [[[ " + ${MICROSERVICE} + " ]]] in [[[ " + ${ENVIRONMENT} + " ]]] on [[[ " + ${INSTANCE} + " ]]]..."

java -Dserver.port=8080 -DKUBE_ADMIN_HOST=${KUBE_ADMIN_HOST} -DKUBE_ADMIN_PORT=${KUBE_ADMIN_PORT} -DKUBE_PROFILE=${ENVIRONMENT} -Dspring.profiles.active=${ENVIRONMENT} -Dserver.ssl.enabled=false -jar ${MICROSERVICE}/${MICROSERVICE}-*.jar

sleep 15

NEWPID=`ps -ef | grep java | grep ${MICROSERVICE} | awk '{print $2}'`

if [[ -z "${NEWPID}" ]];
then
    echo "*** New PID for KUBE Microservice not detected...  Exiting!!! See logs for more details ***"
    exit 1
fi

echo "STARTED :::>>> KUBE Microservice [[[ " + ${MICROSERVICE} + " ]]] in [[[ " + ${ENVIRONMENT} + " ]]]::: PID :::>>> ${NEWPID}"

exit 0