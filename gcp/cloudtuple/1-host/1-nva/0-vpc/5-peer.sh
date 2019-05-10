gcloud beta compute networks peerings create host-trust-to-orange \
  --network nva-trust \
  --peer-network vpc \
  --peer-project orange-project-c3 \
  --import-custom-routes \
  --export-custom-routes

gcloud beta compute networks peerings create host-vpc-to-host-trust \
  --network vpc \
  --peer-network nva-trust \
  --peer-project host-project-39 \
  --import-custom-routes \
  --export-custom-routes

gcloud beta compute networks peerings create host-trust-to-host-vpc \
  --network nva-trust \
  --peer-network vpc \
  --peer-project host-project-39 \
  --import-custom-routes \
  --export-custom-routes
