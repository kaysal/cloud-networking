#!/bin/bash -xe

cd
export GKE_DIRECTORY=~/tf/gcp/cloudtuple/2-service/0-main/gke/clust-w1/scripts/php
export PROJECT_ID=gke-service-project-1b
export UBUNTU_WEB=gcr.io/${PROJECT_ID}/php:v1
export REGION=europe-west1
export SERVICE_ACCOUNT=~/tf/credentials/gke-service-project.json
export CLUSTER='clust-w1'
gcloud config set compute/region ${REGION}
gcloud config set project $PROJECT_ID
gcloud auth activate-service-account --key-file ${SERVICE_ACCOUNT}
gcloud auth configure-docker
gcloud container clusters get-credentials ${CLUSTER} --region=${REGION}
gcloud compute instances list
kubectl config current-context

# Prepare GCR Container Images
#=============================
# hello-world exposed on ILB
cd ${GKE_DIRECTORY}
docker build -t ${UBUNTU_WEB} .
docker push ${UBUNTU_WEB}

# docker run --rm -p 4000:8080 ${UBUNTU_WEB}
