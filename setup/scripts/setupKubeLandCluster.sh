#!/bin/sh
set -o errexit

echo "CREATING :::>>> Registry ::: [[[ kube-land-registry ]]]..."

# desired cluster name; default is "kind"
KIND_CLUSTER_NAME="kube-land"

# create registry container unless it already exists
reg_name='kube-land-registry'
reg_port='5000'
running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
if [ "${running}" != 'true' ]; then
  docker run \
    -d --restart=always -p "${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi
reg_ip="$(docker inspect -f '{{.NetworkSettings.IPAddress}}' "${reg_name}")"

echo "CREATED :::>>> Registry ::: [[[ kube-land-registry ]]]..."

echo "CREATING :::>>> Cluster ::: [[[ kube-land ]]]..."

# create a cluster with the local registry enabled in containerd
cat <<EOF | kind create cluster --name "${KIND_CLUSTER_NAME}" --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:${reg_port}"]
    endpoint = ["http://${reg_ip}:${reg_port}"]
EOF

kind get clusters

echo "CREATED :::>>> Cluster ::: [[[ kube-land ]]]..."