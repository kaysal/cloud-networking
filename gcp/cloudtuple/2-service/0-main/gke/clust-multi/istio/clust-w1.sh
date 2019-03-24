#! /bin/bash
export PATH=${HOME}/.bin:${PATH}
export proj=~/tf/gcp/cloudtuple/2-service/0-main/gke/istio-burst
export cluster=clust-w1
export zone=europe-west1-b

kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user=$(gcloud config get-value core/account)
