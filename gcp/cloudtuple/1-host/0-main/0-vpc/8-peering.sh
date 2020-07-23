#!/bin/bash

gcloud beta compute networks peerings create host-to-orange \
  --network vpc \
  --peer-network vpc \
  --peer-project orange-project-c3 \
  --import-custom-routes \
  --export-custom-routes
