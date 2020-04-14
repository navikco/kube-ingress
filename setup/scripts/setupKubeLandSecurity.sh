#!/bin/bash

set -e

if [[ $# -eq 1 ]]
then

    ENVIRONMENT=${1}
    echo "ENVIRONMENT :::>>> ${ENVIRONMENT}"

else
    echo "Usage: . ./setupKubeLandSecurity.sh <<ENVIRONMENT>>"
    exit 1
fi

cd ../cluster/kube-${ENVIRONMENT}/

echo "CREATING :::>>> K8S ServiceAccount for KUBE ::: [[[ ${ENVIRONMENT} ]]]..."

kubectl create -f kube-${ENVIRONMENT}-admin.yml

kubectl get serviceAccounts --namespace=kube-${ENVIRONMENT}

kubectl describe serviceAccount kube-${ENVIRONMENT}-admin --namespace=kube-${ENVIRONMENT}

echo "CREATED :::>>> K8S ServiceAccount for KUBE ::: [[[ ${ENVIRONMENT} ]]]..."

echo "CREATING :::>>> K8S Cluster VIEW Role Binding for KUBE ::: [[[ ${ENVIRONMENT} ]]]..."

kubectl create -f kube-${ENVIRONMENT}-admin-cluster-role-binding.yml

kubectl get clusterRoleBindings --namespace=kube-${ENVIRONMENT}

kubectl describe clusterRoleBinding kube-${ENVIRONMENT}-admin-cluster-role-binding --namespace=kube-${ENVIRONMENT}

echo "CREATED :::>>> K8S Cluster VIEW Role Binding for KUBE ::: [[[ ${ENVIRONMENT} ]]]..."

exit 0
