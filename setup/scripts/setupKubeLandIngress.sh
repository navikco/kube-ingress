#!/bin/bash

set -e

if [[ $# -eq 1 ]]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

else
    echo "Usage: . ./setupKubeLandIngress.sh <<ENVIRONMENT>>"
    exit 1
fi

cd ../cluster/

echo "CREATING :::>>> K8S Ingress Controller for Kube ::: [[[ ${ENVIRONMENT} ]]]..."

kubectl apply -f kube-ingress-controller.yml

sleep 20

kubectl apply -f kube-ingress-service.yml

kubectl patch deployments -n ingress-nginx nginx-ingress-controller -p '{"spec":{"template":{"spec":{"containers":[{"name":"nginx-ingress-controller","ports":[{"containerPort":80,"hostPort":80},{"containerPort":443,"hostPort":443}]}],"nodeSelector":{"ingress-ready":"true"},"tolerations":[{"key":"node-role.kubernetes.io/master","operator":"Equal","effect":"NoSchedule"}]}}}}'

echo "CREATED :::>>> K8S Ingress Controller for KUBE ::: [[[ ${ENVIRONMENT} ]]]..."

echo "CREATING :::>>> K8S Ingress Service for KUBE ::: [[[ ${ENVIRONMENT} ]]]..."

kubectl create -f kube-${ENVIRONMENT}/kube-ingress-routes.yml

echo "CREATED :::>>> K8S Ingress Service for KUBE ::: [[[ ${ENVIRONMENT} ]]]..."

exit 0
