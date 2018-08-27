#!/bin/bash -xe
export REGION=europe-west1
export ZONE=europe-west1-b
gcloud config set compute/zone ${ZONE}
gcloud compute networks subnets list --network default
gcloud auth activate-service-account --key-file ~/tf/credentials/k8s-service-project.json
gcloud container clusters get-credentials private-zonal-clust --zone=europe-west1-b
kubectl config current-context
gcloud container clusters describe private-zonal-clust --zone=europe-west1-b
kubectl config view
kubectl apply -f ~/tf/gcp/cloudnet18/gke/3-1-zonal-private-clust/scripts/hello-allow-from-foo.yaml
kubectl run hello-web --labels app=hello \
    --image=gcr.io/google-samples/hello-app:1.0 --port 8080 --expose
kubectl apply -f ~/tf/gcp/cloudnet18/gke/3-1-zonal-private-clust/scripts/foo-allow-to-hello.yaml
kubectl run hello-web-2 --labels app=hello-2 \
    --image=gcr.io/google-samples/hello-app:1.0 --port 8080 --expose

# kubectl delete services hello-web
# kubectl delete services hello-web-2
