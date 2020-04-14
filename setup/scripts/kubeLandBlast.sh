#!/bin/bash

set -e

if [[ $# -eq 1 ]]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

else
    echo "Usage: . ./kubeLandBlast.sh <<ENVIRONMENT>>"
    exit 1
fi

pkill -f k8dash | true

pkill -f 8761 | true

pkill -f 8000 | true

./destroyKubeLandCluster.sh

./setupKubeLandCluster.sh

kind get clusters

./setupKubeLandK8Dash.sh

echo "CREATING :::>>> Namespace ::: [[[ ${ENVIRONMENT} ]]]..."

K8S_MASTER_IP=$(echo $(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' | awk '{print $1;}'))
echo "Kube Master IP >>> $K8S_MASTER_IP"

cd ../cluster/kube-${ENVIRONMENT}/

kubectl create -f kube-${ENVIRONMENT}.yml

echo "CREATED :::>>> Namespace ::: [[[ ${ENVIRONMENT} ]]]..."

kubectl get namespaces

cd ../../scripts/

./setupKubeLandSecurity.sh ${ENVIRONMENT}

./setupKubeLandIngress.sh ${ENVIRONMENT}

echo "CREATING :::>>> Microservices in ::: [[[ ${ENVIRONMENT} ]]]..."

./setupKubeLandDeployment.sh ${ENVIRONMENT} admin

./setupKubeLandDeployment.sh ${ENVIRONMENT} accounts

./setupKubeLandDeployment.sh ${ENVIRONMENT} customers

./setupKubeLandDeployment.sh ${ENVIRONMENT} users

sleep 40

echo "CREATED :::>>> Microservices in ::: [[[ ${ENVIRONMENT} ]]]..."

echo "FORWARDING :::>>> PORTS in ::: [[[ ${ENVIRONMENT} ]]]..."

kubectl port-forward service/ingress-nginx 8080:80 --namespace=ingress-nginx &
kubectl port-forward deployment/k8dash 8000:4654 --namespace=kube-system &

echo "FORWARDED :::>>> PORTS in ::: [[[ ${ENVIRONMENT} ]]]..."

echo "GENERATING :::>>> Access Key For ::: [[[ K8Dash ]]]..."

./fetchKubeLandK8DashAccessKey.sh

echo "GENERATED :::>>> Access Key For ::: [[[ K8Dash ]]]..."

exit 0
