gcloud alpha compute networks peerings create host-to-vu16 \
      --network vpc \
      --peer-project vpcuser16project \
      --peer-network vu16-vpc \
      --import-custom-routes \
      --export-custom-routes \
      --auto-create-routes
