#! /bin/bash

# SCENARIO 1: REGULAR PERIMETER
 #=============================
export ORGANIZATION_ID='605735072113'
export PROJECTS='projects/523293824833,projects/279360189369'
export PERIMETER_NAME='hostPerimiter'
export RESTRICTED_SERVICES='bigquery.googleapis.com,storage.googleapis.com'

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

# Create a regular service perimiter
gcloud beta access-context-manager perimeters create $PERIMETER_NAME \
  --title='host-perimiter' \
  --resources=$PROJECTS \
  --restricted-services=$RESTRICTED_SERVICES \
  --policy=$POLICY


gcloud beta access-context-manager perimeters delete $PERIMETER_NAME
gcloud beta access-context-manager policies delete $POLICY


# SCENARIO 2: PERIMETER BRIDGE
 #=============================
export ORGANIZATION_ID='605735072113'
export PROJECTS_HOST_PRJ_GRP='projects/523293824833'
export PROJECTS_SVC_PRJ_GRP='projects/279360189369'
export PERIMETER_HOST_PRJ_GRP='hostPerimiter'
export PERIMETER_SVC_PRJ_GRP='applePerimiter'
export HOST_APPLE_BRIDGE='hostAppleBridge'
export HOST_UNRESTRICTED_SERVICES='dns.googleapis.com'
export HOST_RESTRICTED_SERVICES='bigquery.googleapis.com,storage.googleapis.com'
export APPLE_RESTRICTED_SERVICES='bigquery.googleapis.com,storage.googleapis.com'

# Create access policy object
gcloud beta access-context-manager policies create \
  --organization $ORGANIZATION_ID \
  --title host-access-policy

# Verify and set the access policy as the default policy in the gcloud
gcloud beta access-context-manager policies list \
    --organization=$ORGANIZATION_ID

# Cache the policy value instead of adding it explicitly to each command
export POLICY='1091396325242'
gcloud config set access_context_manager/policy $POLICY

# Create a regular service perimiter around host project group
gcloud beta access-context-manager perimeters create $PERIMETER_HOST_PRJ_GRP \
  --title='host-prj-grp-perimiter' \
  --resources=$PROJECTS_HOST_PRJ_GRP \
  --restricted-services=$HOST_RESTRICTED_SERVICES

gcloud beta access-context-manager perimeters update $PERIMETER_HOST_PRJ_GRP \
   --set-unrestricted-services='*'

# Create a regular service perimiter around service project group
gcloud beta access-context-manager perimeters create $PERIMETER_SVC_PRJ_NAME \
  --title='service-prj-grp-perimiter' \
  --resources=$PROJECTS_SVC_PRJ_GRP \
  --restricted-services=$SERVICES_SVC_PRJ_GRP

# create a bridge between the 2 perimeters
export BRIDGED_PROJECTS='projects/523293824833,projects/279360189369'
gcloud beta access-context-manager perimeters create $PERIMETER_BRIDGE_NAME \
  --title="host-apple-bridge" \
  --perimeter-type=bridge \
  --resources=$BRIDGED_PROJECTS

gcloud beta access-context-manager perimeters delete $PERIMETER_HOST_PRJ_NAME
gcloud beta access-context-manager perimeters delete $PERIMETER_SVC_PRJ_NAME
gcloud beta access-context-manager perimeters delete $PERIMETER_BRIDGE_NAME
gcloud beta access-context-manager policies delete $POLICY
