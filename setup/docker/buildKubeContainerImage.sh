#!/bin/bash

set -e

if [[ $# -eq 1 ]]
then

    MICROSERVICE=${1}
    echo "MICROSERVICE :::>>> ${MICROSERVICE}"

else
    echo "Usage: . ./buildKubeContainerImage.sh <<MICROSERVICE>> "
    exit 1
fi

###################
###ONLY SET THIS###
###################
KUBE_HOME=${PWD}
KUBE_APPS_HOME=${PWD}/../../apps/
KUBE_DOCKER_HOST_HOME=/opt/mw

docker ps

docker images

#Stop and Remove currently running (If any!) Docker Containers for SCN Weblogic Image
echo "STOPPING :::>>> KUBE Docker Container ::: [[[ " + ${MICROSERVICE} + " ]]]..."
docker rm -f $(docker stop $(docker ps -a -q -f name=${MICROSERVICE})) | true
echo "STOPPED :::>>> KUBE Docker Container ::: [[[ " + ${MICROSERVICE} + " ]]]..."

#Remove Docker KUBE Image
echo "STOPPING :::>>> KUBE Docker Image ::: [[[ " + ${MICROSERVICE} + " ]]]..."
docker rmi -f $(docker images | grep ${MICROSERVICE}) | true
docker rmi -f $(docker images | grep none) | true
echo "STOPPED :::>>> KUBE Docker Image ::: [[[ " + ${MICROSERVICE} + " ]]]..."

docker ps

docker images

rm -rf ${KUBE_HOME}/build/${MICROSERVICE}*.jar

cp ${KUBE_APPS_HOME}/${MICROSERVICE}/build/libs/${MICROSERVICE}*.jar ${KUBE_HOME}/build/

chmod 700 ${KUBE_HOME}/build/*.jar

cd ${KUBE_HOME}/build/

echo "BUILDING :::>>> KUBE Docker Image ::: [[[ " + ${MICROSERVICE} + " ]]]..."
docker build --build-arg kubeMicroservice=${MICROSERVICE} -t localhost:5000/${MICROSERVICE}:1.1.1_12 .
echo "BUILT :::>>> KUBE Docker Image ::: [[[ " + ${MICROSERVICE} + " ]]]..."

docker ps

docker images

echo "PUSHING :::>>> KUBE Docker Image to Docker Registry ::: [[[ " + ${MICROSERVICE} + " ]]]..."
docker tag localhost:5000/${MICROSERVICE}:1.1.1_12 localhost:5000/${MICROSERVICE}:latest
docker push localhost:5000/${MICROSERVICE}:1.1.1_12
docker push localhost:5000/${MICROSERVICE}:latest
echo "PUSHED :::>>> KUBE Docker Image to Docker Registry ::: [[[ " + ${MICROSERVICE} + " ]]]..."

#Remove LOCAL Docker KUBE Image
echo "DELETING LOCAL :::>>> KUBE Docker Image ::: [[[ " + ${MICROSERVICE} + " ]]]..."
docker rmi -f $(docker images | grep ${MICROSERVICE}) | true
echo "DELETED LOCAL :::>>> KUBE Docker Image ::: [[[ " + ${MICROSERVICE} + " ]]]..."

rm -rf ${KUBE_HOME}/build/${MICROSERVICE}*.jar
