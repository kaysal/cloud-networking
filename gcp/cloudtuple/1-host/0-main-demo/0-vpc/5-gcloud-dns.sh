#!/bin/bash

gcloud beta dns managed-zones create cloudtuple-private \
  --project=host-project-f0 \
  --networks=vpc \
  --description='private cloudtuple.com' \
  --dns-name=cloudtuple.com. \
  --visibility=private

gcloud beta dns managed-zones create west1-cloudtuples \
  --project=host-project-f0 \
  --networks=vpc \
  --description='external aws zone' \
  --dns-name=cloudtuples.com. \
  --visibility=private \
  --forwarding-targets=172.16.10.100
