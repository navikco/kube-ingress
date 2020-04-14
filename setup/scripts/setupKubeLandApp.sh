#!/bin/bash

set -e

if [[ $# -eq 2 ]]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

    MICROSERVICE=${2}
    echo "MICROSERVICE :::>>> ${MICROSERVICE}"
else
    echo "Usage: . ./setupKubeLandApp.sh <<ENVIRONMENT>> <<MICROSERVICE>>"
    exit 1
fi

cd ../cluster/kube-${ENVIRONMENT}/

kubectl get namespaces

kubectl get all --namespace=kube-${ENVIRONMENT}

echo "DELETING :::>>> [[[ " + ${MICROSERVICE} + " ]]] in [[[ " + ${ENVIRONMENT} + " ]]]..."

kubectl delete -f ${MICROSERVICE}/${MICROSERVICE}-deployment.yml | true
kubectl delete -f ${MICROSERVICE}/${MICROSERVICE}-service.yml | true

sleep 10

echo "DELETED :::>>> [[[ " + ${MICROSERVICE} + " ]]] in [[[ " + ${ENVIRONMENT} + " ]]]..."

kubectl get all --namespace=kube-${ENVIRONMENT}

echo "STARTING :::>>> [[[ " + ${MICROSERVICE} + " ]]] in [[[ " + ${ENVIRONMENT} + " ]]]..."

kubectl create -f ${MICROSERVICE}/${MICROSERVICE}-deployment.yml
kubectl create -f ${MICROSERVICE}/${MICROSERVICE}-service.yml

sleep 20

kubectl get all --namespace=kube-${ENVIRONMENT}

echo "STARTED :::>>> [[[ " + ${MICROSERVICE} + " ]]] in [[[ " + ${ENVIRONMENT} + " ]]]..."

exit 0
