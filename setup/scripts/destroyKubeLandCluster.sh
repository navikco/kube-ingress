echo "DESTROYING :::>>> Cluster ::: [[[ kube-land ]]]..."

pkill -f k8dash | true

pkill -f 8080 | true

pkill -f 8000 | true

kind delete cluster --name kube-land

sleep 20

docker stop zoobab/kind:latest

docker stop kube-land-registry
docker rm -f kube-land-registry

sleep 20

echo "DESTROYED :::>>> Cluster ::: [[[ kube-land ]]]..."