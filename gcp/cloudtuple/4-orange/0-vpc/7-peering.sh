#!/bin/bash

gcloud beta compute networks peerings create orange-vpc-to-host-trust \
  --network vpc \
  --peer-network nva-trust \
  --peer-project host-project-39 \
  --import-custom-routes \
  --export-custom-routes

gcloud beta compute networks peerings create orange-vpc-to-host-vpc \
  --network vpc \
  --peer-network vpc \
  --peer-project host-project-39 \
  --import-custom-routes \
  --export-custom-routes
