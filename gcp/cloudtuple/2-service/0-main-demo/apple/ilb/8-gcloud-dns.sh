#!/bin/bash

gcloud beta dns record-sets transaction start \
  --project=host-project-f0 \
  --zone=cloudtuple-private

gcloud dns  record-sets transaction add 10.100.10.99 \
  --project=host-project-f0 \
  --zone=cloudtuple-private \
  --name=ilb.cloudtuple.com. \
  --type=A \
  --ttl=300

gcloud dns record-sets transaction execute \
  --project=host-project-f0 \
  --zone=cloudtuple-private
