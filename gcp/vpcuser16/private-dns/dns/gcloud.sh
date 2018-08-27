#!/bin/bash

export PROJECT_ID=vpcuser16project
export DNS_ZONE=gcp-cloudtuple
export DNS_NAME=gcp.cloudtuple.com.

gcloud beta dns managed-zones create ${DNS_ZONE} \
  --project=${PROJECT_ID} \
  --description='private dns zone prod.gcp' \
  --dns-name=gcp.cloudtuple.com. \
  --visibility=private \
  --networks vpc

gcloud beta dns record-sets transaction start \
  --project=${PROJECT_ID} \
  --zone=${DNS_ZONE}

gcloud dns record-sets transaction add 10.200.10.100 \
  --name=app.${DNS_NAME} \
  --ttl=300 \
  --type=A

gcloud dns record-sets transaction execute \
  --project=${PROJECT_ID} \
  --zone=${DNS_ZONE}
