#!/bin/bash

set -e

if [[ $# -eq 3 ]]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

    MICROSERVICE=${2}
    echo "MICROSERVICE :::>>> ${MICROSERVICE}"

    BUILD=$3
    echo "BUILD :::>>> ${BUILD}"

elif [[ $# -eq 2 ]]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

    MICROSERVICE=${2}
    echo "MICROSERVICE :::>>> ${MICROSERVICE}"

    BUILD="build"
    echo "BUILD :::>>> ${BUILD}"

else
    echo "Usage: . ./setupKubeLandDeployment.sh <<ENVIRONMENT>> <<MICROSERVICE>>"
    exit 1
fi

###################
###ONLY SET THIS###
###################

KUBE_SCRIPTS_HOME=$PWD
echo "KUBE_SCRIPTS_HOME ::: [[[ ${KUBE_SCRIPTS_HOME} ]]]..."
KUBE_HOME=../../
echo "KUBE_HOME ::: [[[ ${KUBE_HOME} ]]]..."
KUBE_APPS_HOME=${PWD}/../../apps/
echo "KUBE_APPS_HOME ::: [[[ ${KUBE_APPS_HOME} ]]]..."
KUBE_DOCKER_HOST_HOME=/opt/mw

if [[ "$BUILD" == "build"  ]]
then
    echo "Building ::: [[[ ${MICROSERVICE} ]]] in [[[ ${ENVIRONMENT} ]]]..."

    cd ${KUBE_APPS_HOME}/${MICROSERVICE}/
    ./gradlew clean build

    echo "Built ::: [[[ ${MICROSERVICE} ]]] in [[[ ${ENVIRONMENT} ]]]..."
fi

echo "Build Container Image ::: [[[ ${MICROSERVICE} ]]] in [[[ ${ENVIRONMENT} ]]]..."

cd ${KUBE_HOME}/setup/docker/

./buildKubeContainerImage.sh ${MICROSERVICE}

echo "Built Container Image ::: [[[ ${MICROSERVICE} ]]] in [[[ ${ENVIRONMENT} ]]]..."

echo "Deploy Kubernetes Pod ::: [[[ ${MICROSERVICE} ]]] in [[[ ${ENVIRONMENT} ]]]..."

cd ${KUBE_SCRIPTS_HOME}/

./setupKubeLandApp.sh ${ENVIRONMENT} ${MICROSERVICE}

echo "Deployed Kubernetes Pod ::: [[[ ${MICROSERVICE} ]]] in [[[ ${ENVIRONMENT} ]]]..."

exit 0
