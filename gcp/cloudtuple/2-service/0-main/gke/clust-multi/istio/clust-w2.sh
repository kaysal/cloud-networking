#! /bin/bash
export proj=~/tf/gcp/cloudtuple/2-service/0-main/gke/istio-burst
export cluster=clust-w2

kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user=$(gcloud config get-value core/account)

ALL_CLUSTER_CIDRS=$(gcloud container clusters list \
--filter="(name=clust-w1 OR name=clust-w2)" \
--format='value(clusterIpv4Cidr)' | sort | uniq)

ALL_CLUSTER_NETTAGS=$(gcloud compute instances list \
--filter="(metadata.cluster-name=clust-w1 OR metadata.cluster-name=clust-w2)" \
--format='value(tags.items.[0])' | sort | uniq)
