#! /bin/bash

gcloud compute disks create multi-ip-subnet-disk \
	--project=kayode-salawu \
	--zone=europe-west1-b \
	--type=pd-standard \
	--image=debian-9-tf-nightly-v20180922 \
	--image-project=ml-images \
	--size=10GB

gcloud compute images create debian-9-multi-ip-subnet \
     --source-disk multi-ip-subnet-disk \
     --source-disk-zone europe-west1-b \
     --guest-os-features MULTI_IP_SUBNET

gcloud compute images describe debian-9-multi-ip-subnet
