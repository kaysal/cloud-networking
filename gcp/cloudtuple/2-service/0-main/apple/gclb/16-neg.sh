#!/bin/bash

export APPLE_PROJECT=apple-service-project-b5
export HOST_PROJECT=host-project-39
export EPG_APP1_EU_W3A=app1-eu-w3a
export EPG_APP1_EU_W3B=app1-eu-w3b
export EPG_APP2_EU_W3A=app2-eu-w3a
export ZONE_APP1_EU_W3A=europe-west3-a
export ZONE_APP1_EU_W3B=europe-west3-b
export ZONE_APP2_EU_W3A=europe-west3-a
export NETWORK=projects/$HOST_PROJECT/global/networks/vpc
export SUBNET=projects/$HOST_PROJECT/regions/europe-west3/subnetworks/apple-eu-w3-10-200-10
export DEV_NEG_APP1_BE_SVC=gclb-dev-neg-app1-be-svc
export DEV_NEG_APP2_BE_SVC=gclb-dev-neg-app2-be-svc
export APP1_NEG_HC=gclb-app1-neg-hc
export APP2_NEG_HC=gclb-app2-neg-hc

gcloud beta compute  network-endpoint-groups create $EPG_APP1_EU_W3A \
  --project=$APPLE_PROJECT \
  --zone=$ZONE_APP1_EU_W3A \
  --network=$NETWORK \
  --subnet=$SUBNET \
  --network-endpoint-type=GCE_VM_IP_PORT \
  --default-port=80

gcloud beta compute  network-endpoint-groups create $EPG_APP1_EU_W3B \
  --project=$APPLE_PROJECT \
  --zone=$ZONE_APP1_EU_W3B \
  --network=$NETWORK \
  --subnet=$SUBNET \
  --network-endpoint-type=GCE_VM_IP_PORT \
  --default-port=80

gcloud beta compute  network-endpoint-groups create $EPG_APP2_EU_W3A \
  --project=$APPLE_PROJECT \
  --zone=$ZONE_APP2_EU_W3A \
  --network=$NETWORK \
  --subnet=$SUBNET \
  --network-endpoint-type=GCE_VM_IP_PORT \
  --default-port=8080

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

gcloud beta compute health-checks create http $APP1_NEG_HC \
  --port=80

gcloud beta compute health-checks create http $APP2_NEG_HC \
  --port=8080

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
