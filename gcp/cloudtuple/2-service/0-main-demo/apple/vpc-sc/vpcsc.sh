#! /bin/bash

export ORGANIZATION_ID='605735072113'
export PROJECTS=projects/523293824833
export PERIMETER_NAME=hostPerimiter
export SERVICES=bigquery.googleapis.com,storage.googleapis.com

# Create access policy object
gcloud beta access-context-manager policies create \
  --organization $ORGANIZATION_ID \
  --title host-access-policy

# Verify and set the access policy as the default policy in the gcloud
gcloud beta access-context-manager policies list \
    --organization=$ORGANIZATION_ID

# Cache the policy value instead of adding it explicitly to each command
export POLICY='109938552351'
gcloud config set access_context_manager/policy $POLICY

# Create service perimiter
gcloud beta access-context-manager perimeters create $PERIMETER_NAME \
  --title='host-perimiter' \
  --resources=$PROJECTS \
  --restricted-services=$SERVICES \
  --policy=$POLICY


gcloud beta access-context-manager perimeters delete $PERIMETER_NAME
gcloud beta access-context-manager policies delete $POLICY
