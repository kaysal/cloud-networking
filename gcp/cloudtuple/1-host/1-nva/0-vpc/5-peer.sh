gcloud alpha compute networks peerings create host-trust-to-orange \
  --network nva-trust \
  --peer-network vpc \
  --peer-project orange-project-c3 \
  --import-custom-routes \
  --export-custom-routes
