#!/bin/bash -xe

export GKE_DIRECTORY=~/tf/gcp/cloudtuple/2-service/0-main/gke/clust-w2/apps/1-php
export APP_KEY='gke-service-project-k8sapp.json'
export CREDENTIAL_DIR=~/tf/credentials

cd ${CREDENTIAL_DIR}
kubectl create secret generic php-key --from-file=key.json=${APP_KEY} || true
kubectl get secret
cd ${GKE_DIRECTORY}
kubectl apply -f php.yaml
