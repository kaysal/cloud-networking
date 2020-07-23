#!/bin/bash

PROJECT_ID=orange-project-c3
REGION=europe-west1
CLUSTER='clust-w1'

gcloud config set project $PROJECT_ID
gcloud auth configure-docker
gcloud config set compute/region ${REGION}
gcloud container clusters get-credentials ${CLUSTER} --region=${REGION}
skaffold run
