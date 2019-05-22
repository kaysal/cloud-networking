#!/bin/bash

APPLE_PROJECT=apple-service-project-b5
HOST_PROJECT=host-project-39
EPG_APP1_EU_W3A=gclb-app1-eu-w3a
EPG_APP1_EU_W3B=gclb-app1-eu-w3b
EPG_APP2_EU_W3A=gclb-app2-eu-w3a
ZONE_APP1_EU_W3A=europe-west3-a
ZONE_APP1_EU_W3B=europe-west3-b
ZONE_APP2_EU_W3A=europe-west3-a
NETWORK=projects/$HOST_PROJECT/global/networks/vpc
SUBNET=projects/$HOST_PROJECT/regions/europe-west3/subnetworks/apple-eu-w3-10-200-10
DEV_NEG_APP1_BE_SVC=gclb-dev-neg-app1-be-svc
DEV_NEG_APP2_BE_SVC=gclb-dev-neg-app2-be-svc
APP1_NEG_HC=gclb-app1-neg-hc
APP2_NEG_HC=gclb-app2-neg-hc

# network endpoint groups

gcloud beta compute network-endpoint-groups update $EPG_APP1_EU_W3A \
  --zone=$ZONE_APP1_EU_W3A \
  --add-endpoint 'instance=gclb-neg-eu-w3-vm1,ip=10.200.10.11,port=80' \
  --add-endpoint 'instance=gclb-neg-eu-w3-vm2,ip=10.0.82.22,port=80'

gcloud beta compute network-endpoint-groups update $EPG_APP1_EU_W3B \
  --zone=$ZONE_APP1_EU_W3B \
  --add-endpoint 'instance=gclb-neg-eu-w3-vm3,ip=10.0.83.33,port=80'

gcloud beta compute network-endpoint-groups update $EPG_APP2_EU_W3A \
  --zone=$ZONE_APP2_EU_W3A \
  --add-endpoint 'instance=gclb-neg-eu-w3-vm1,ip=10.0.81.11,port=8080'

# health checks

gcloud beta compute health-checks create http $APP1_NEG_HC \
  --port=80

gcloud beta compute health-checks create http $APP2_NEG_HC \
  --port=8080

# backend services

gcloud compute backend-services create $DEV_NEG_APP1_BE_SVC \
  --global \
  --health-checks $APP1_NEG_HC

gcloud compute backend-services create $DEV_NEG_APP2_BE_SVC \
  --global \
  --health-checks $APP2_NEG_HC

gcloud beta compute backend-services add-backend $DEV_NEG_APP1_BE_SVC \
   --network-endpoint-group $EPG_APP1_EU_W3A \
   --network-endpoint-group-zone=$ZONE_APP1_EU_W3A \
   --global \
   --balancing-mode=RATE \
   --max-rate-per-endpoint=5

gcloud beta compute backend-services add-backend $DEV_NEG_APP1_BE_SVC \
   --network-endpoint-group $EPG_APP1_EU_W3B \
   --network-endpoint-group-zone=$ZONE_APP1_EU_W3B \
   --global \
   --balancing-mode=RATE \
   --max-rate-per-endpoint=5

gcloud beta compute backend-services add-backend $DEV_NEG_APP2_BE_SVC \
   --network-endpoint-group $EPG_APP2_EU_W3A \
   --network-endpoint-group-zone=$ZONE_APP2_EU_W3A \
   --global \
   --balancing-mode=RATE \
   --max-rate-per-endpoint=5

# delete

gcloud beta compute backend-services delete $DEV_NEG_APP1_BE_SVC --global -q
gcloud beta compute backend-services delete $DEV_NEG_APP2_BE_SVC --global -q

gcloud beta compute health-checks delete $APP1_NEG_HC -q
gcloud beta compute health-checks delete $APP2_NEG_HC -q

gcloud beta compute network-endpoint-groups update $EPG_APP1_EU_W3A \
  --zone=$ZONE_APP1_EU_W3A \
  --remove-endpoint='instance=gclb-neg-eu-w3-vm1,ip=10.200.10.11,port=80' \
  --remove-endpoint 'instance=gclb-neg-eu-w3-vm2,ip=10.0.82.22,port=80'

gcloud beta compute network-endpoint-groups update $EPG_APP1_EU_W3B \
  --zone=$ZONE_APP1_EU_W3B \
  --remove-endpoint 'instance=gclb-neg-eu-w3-vm3,ip=10.0.83.33,port=80'

gcloud beta compute network-endpoint-groups update $EPG_APP2_EU_W3A \
  --zone=$ZONE_APP2_EU_W3A \
  --remove-endpoint 'instance=gclb-neg-eu-w3-vm1,ip=10.0.81.11,port=8080'
