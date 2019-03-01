#!/bin/bash -xe

export GKE_DIRECTORY=~/tf/gcp/cloudtuple/2-service/0-main-demo/gke/clust-w1/scripts/php

cd ~/tf/credentials
kubectl create secret generic php-key \
  --from-file=key.json='gke-service-project-k8sapp.json' || true
kubectl get secret

cd ${GKE_DIRECTORY}
kubectl apply -f php.yaml

kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
