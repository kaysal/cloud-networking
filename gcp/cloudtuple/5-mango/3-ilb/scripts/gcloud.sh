#!/bin/bash

gcloud dns managed-zones create gcp-cloudtuple\
--project=host-project-f0 \
--description= \
--dns-name=gcp.cloudtuple.com. \
--visibility=private \
--networks vpc
