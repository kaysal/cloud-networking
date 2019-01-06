#!/bin/bash

export PROJECT=mango-service-project-b4

gcloud beta dns managed-zones create private-mango-cloudtuple \
  --project=$PROJECT \
  --description="private zone for mango project gce" \
  --dns-name=mango.cloudtuple.com. \
  --visibility=private --networks vpc

gcloud beta dns managed-zones create private-aws-west1-cloudtuples \
  --project=$PROJECT \
  --description="zone queries to aws west1 region" \
  --dns-name=west1.cloudtuples.com. \
  --visibility=private --networks vpc \
  --forwarding-targets=172.16.10.100

gcloud beta dns managed-zones create private-aws-east1-cloudtuples \
  --project=$PROJECT \
  --description="zone queries to aws east1 region inbound endpoint" \
  --dns-name=east1.cloudtuples.com. \
  --visibility=private --networks vpc \
  --forwarding-targets=172.18.11.51,172.18.10.200

gcloud beta dns policies create inbound-policy \
  --description='inbound from onprem' \
  --networks=vpc \
  --enable-inbound-forwarding
