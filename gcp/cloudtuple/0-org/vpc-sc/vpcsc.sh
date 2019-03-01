#! /bin/bash

# SCENARIO 1: REGULAR PERIMETER
 #=============================
export ORGANIZATION_ID='605735072113'
export PROJECTS='projects/816434871149,projects/99004589846'
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
export PROJECT_HOST='projects/816434871149'
export PROJECT_APPLE='projects/99004589846'
export PROJECT_MANGO='projects/441070782315'
export PERIMETER_HOST='hostPerimiter'
export PERIMETER_APPLE='applePerimiter'
export PERIMETER_MANGO='mangoPerimiter'
export HOST_APPLE_BRIDGE='hostAppleBridge'
export APPLE_MANGO_BRIDGE='appleMangoBridge'
export HOST_RESTRICTED_SERVICES='storage.googleapis.com'
export APPLE_RESTRICTED_SERVICES='storage.googleapis.com'
export MANGO_RESTRICTED_SERVICES='storage.googleapis.com'

# Create access policy object
gcloud beta access-context-manager policies create \
  --organization $ORGANIZATION_ID \
  --title host-access-policy

# Verify and set the access policy as the default policy in the gcloud
gcloud beta access-context-manager policies list \
    --organization=$ORGANIZATION_ID

# Cache the policy value instead of adding it explicitly to each command
export POLICY='258501025282'
gcloud config set access_context_manager/policy $POLICY


# Create a regular service perimiter around host project
#------------------------------
gcloud beta access-context-manager perimeters create $PERIMETER_HOST \
  --title='host-perimiter' \
  --resources=$PROJECT_HOST \
  --restricted-services=$HOST_RESTRICTED_SERVICES

gcloud beta access-context-manager perimeters update $PERIMETER_HOST \
   --set-unrestricted-services='*'


# Create a regular service perimiter around apple service project
#------------------------------
gcloud beta access-context-manager perimeters create $PERIMETER_APPLE \
  --title='apple-perimiter' \
  --resources=$PROJECT_APPLE \
  --restricted-services=$APPLE_RESTRICTED_SERVICES


# Create a regular service perimiter around mango project
#------------------------------
gcloud beta access-context-manager perimeters create $PERIMETER_MANGO \
  --title='mango-perimiter' \
  --resources=$PROJECT_MANGO \
  --restricted-services=$MANGO_RESTRICTED_SERVICES

gcloud beta access-context-manager perimeters update $PERIMETER_MANGO \
   --set-unrestricted-services='*'


# Create bridges
#------------------------------
# host-apple bridge
gcloud beta access-context-manager perimeters create $HOST_APPLE_BRIDGE \
  --title="host-apple-bridge" \
  --perimeter-type=bridge \
  --resources=$PROJECT_HOST,$PROJECT_APPLE

# apple-mango bridge
gcloud beta access-context-manager perimeters create $APPLE_MANGO_BRIDGE \
  --title="apple-mango-bridge" \
  --perimeter-type=bridge \
  --resources=$PROJECT_APPLE,$PROJECT_MANGO


# Access Levels
#------------------------------
# mango access level
gcloud beta access-context-manager levels create 'mangoAccessLevel' \
   --title 'mango-access-level' \
   --basic-level-spec ~/tf/gcp/cloudtuple/0-org/vpc-sc/mango.yaml \
   --policy=$POLICY

gcloud beta access-context-manager perimeters update $PERIMETER_MANGO \
  --set-access-levels='mangoAccessLevel'


gcloud beta access-context-manager perimeters delete $PERIMETER_HOST
gcloud beta access-context-manager perimeters delete $PERIMETER_APPLE
gcloud beta access-context-manager perimeters delete $HOST_APPLE_BRIDGE
gcloud beta access-context-manager policies delete $POLICY
