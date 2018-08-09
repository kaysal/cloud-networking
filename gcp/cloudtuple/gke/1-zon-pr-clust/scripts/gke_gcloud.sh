#!/bin/bash -xe
export HOST_PROJECT_ID=aa-netsec-host-project
export HOST_PROJECT_NUM=388353563041
export SERVICE_PROJECT_1_ID=aa-gke-service-project
export SERVICE_PROJECT_1_NUM=85229175171

# ===============
# HOST PROJECT
# ===============
gcloud services enable container.googleapis.com --project ${HOST_PROJECT_ID}
gcloud compute networks create shared-net \
    --subnet-mode custom \
    --project ${HOST_PROJECT_ID}

gcloud compute networks subnets create tier-1 \
    --project ${HOST_PROJECT_ID} \
    --network shared-net \
    --range 10.0.4.0/22 \
    --region europe-west1 \
    --secondary-range tier-1-services=10.0.32.0/20,tier-1-pods=10.4.0.0/14

gcloud compute networks subnets create tier-2 \
    --project ${HOST_PROJECT_ID} \
    --network shared-net \
    --range 172.16.4.0/22 \
    --region europe-west1 \
    --secondary-range tier-2-services=172.16.16.0/20,tier-2-pods=172.20.0.0/14

gcloud compute shared-vpc enable ${HOST_PROJECT_ID}

gcloud compute shared-vpc associated-projects add \
    ${SERVICE_PROJECT_1_ID} \
    --host-project ${HOST_PROJECT_ID}

gcloud beta compute networks subnets get-iam-policy tier-1 \
   --project ${HOST_PROJECT_ID} \
   --region europe-west1

# etag: ACAB

export ETAG=ACAB

cat <<EOF > tier-1-policy.yaml
bindings:
- members:
  - serviceAccount:${SERVICE_PROJECT_1_NUM}@cloudservices.gserviceaccount.com
  - serviceAccount:service-${SERVICE_PROJECT_1_NUM}@container-engine-robot.iam.gserviceaccount.com
  role: roles/compute.networkUser
etag: ${ETAG}
EOF

gcloud beta compute networks subnets set-iam-policy tier-1 \
    tier-1-policy.yaml \
    --project ${HOST_PROJECT_ID} \
    --region europe-west1


gcloud projects add-iam-policy-binding ${HOST_PROJECT_ID} \
    --member serviceAccount:service-${SERVICE_PROJECT_1_NUM}@container-engine-robot.iam.gserviceaccount.com \
    --role roles/container.hostServiceAgentUser


# ===============
# SERVICE PROJECT
# ===============
export HOST_PROJECT_ID=aa-netsec-host-project
export HOST_PROJECT_NUM=388353563041
export SERVICE_PROJECT_1_ID=aa-gke-service-project
export SERVICE_PROJECT_1_NUM=85229175171
gcloud services enable container.googleapis.com --project ${SERVICE_PROJECT_1_ID}

gcloud beta container clusters create tier-1-cluster \
    --project ${SERVICE_PROJECT_1_ID} \
    --zone=europe-west1-b \
    --enable-ip-alias \
    --network projects/${HOST_PROJECT_ID}/global/networks/shared-net \
    --subnetwork projects/${HOST_PROJECT_ID}/regions/europe-west1/subnetworks/tier-1 \
    --cluster-secondary-range-name tier-1-pods \
    --services-secondary-range-name tier-1-services


# DELETE
# ===============
# SERVICE PROJECT
# ===============
gcloud container clusters delete tier-1-cluster \
    --project ${SERVICE_PROJECT_1_ID} \
    --zone=europe-west1-b

gcloud compute shared-vpc associated-projects remove ${SERVICE_PROJECT_1_ID} \
    --host-project ${HOST_PROJECT_ID}

# ===============
# HOST PROJECT
# ===============
gcloud compute networks subnets delete tier-1 \
    --project ${HOST_PROJECT_ID} \
    --region europe-west1

gcloud compute networks subnets delete tier-2 \
    --project ${HOST_PROJECT_ID} \
    --region europe-west1

gcloud compute networks delete shared-net --project ${HOST_PROJECT_ID}

gcloud projects remove-iam-policy-binding ${HOST_PROJECT_ID} \
    --member serviceAccount:service-${SERVICE_PROJECT_1_NUM}@container-engine-robot.iam.gserviceaccount.com \
    --role roles/container.hostServiceAgentUser
