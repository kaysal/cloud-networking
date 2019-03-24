#!/bin/bash -xe

export GKE_DIRECTORY=~/tf/gcp/cloudtuple/2-service/0-main/gke/clust-w1/scripts/php

cd ~/tf/credentials
kubectl create secret generic php-key \
  --from-file=key.json='gke-service-project-k8sapp.json' || true
kubectl get secret

cd ${GKE_DIRECTORY}
kubectl apply -f php.yaml
# inject istio sidecar on all pods
kubectl label namespace default istio-injection=enabled || true
# restart pods for sidecar to be installed at pod creation time
kubectl scale deployment php-deploy --replicas=0 -n default
kubectl scale deployment php-deploy --replicas=2 -n default
#kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
