#!/bin/bash

export PROJECT=host-project-39

gcloud beta dns managed-zones create private-prod-cloudtuple \
  --project=$PROJECT \
  --description="private zone for apple project prod vpc" \
  --dns-name=prod.cloudtuple.com. \
  --visibility=private \
  --networks nva-prod
