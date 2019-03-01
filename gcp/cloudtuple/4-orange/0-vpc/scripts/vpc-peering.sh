gcloud alpha compute networks peerings create vu16-to-host \
      --network vu16-vpc \
      --peer-project host-project-f0 \
      --peer-network vpc \
      --import-custom-routes \
      --export-custom-routes \
      --auto-create-routes
