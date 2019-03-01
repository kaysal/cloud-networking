gcloud beta resource-manager folders list
  --organization=$ORG_ID

export ORG_ID=
export FOLDER_DEV_ID=
export FOLDER_PROD_ID=
export SVPC_ADMIN_DEV=admindev@
export SVPC_ADMIN_PROD=adminprod@
export HOST_PROJECT_ID_DEV=
export HOST_PROJECT_ID_PROD=
export SERVICE_PROJECT_ID_DEV_A=
export SERVICE_PROJECT_ID_DEV_B=
export SERVICE_PROJECT_ID_PROD_C=
export SERVICE_PROJECT_ID_PROD_D=

# Prepare your organization
# Prevent accidental deletion of host projects
# Authenticate to gcloud as an Organization Admin

gcloud auth login
gcloud organizations list
gcloud beta resource-manager org-policies enable-enforce \
    --organization $ORG_ID compute.restrictXpnProjectLienRemoval

# Nominate Dev Shared VPC Admin at Folder level
gcloud beta resource-manager folders add-iam-policy-binding $FOLDER_DEV_ID
  --member=$SVPC_ADMIN_DEV
  --role="roles/compute.xpnAdmin"

# Nominate Prod Shared VPC Admin at Organization level
 gcloud organizations add-iam-policy-binding $ORG_ID
    --member=$SVPC_ADMIN_PROD
    --role="roles/compute.xpnAdmin"

gcloud auth revoke

# Setting up Shared VPC at Organization level
# Authenticate to gcloud as a Shared VPC Admin 1
gcloud auth login
gcloud compute shared-vpc enable $HOST_PROJECT_ID_PROD
gcloud compute shared-vpc organizations list-host-projects $ORG_ID

# Setting up Shared VPC at Folder level
# Authenticate to gcloud as a Shared VPC Admin 2
gcloud auth login
gcloud beta compute shared-vpc enable $HOST_PROJECT_ID_DEV
gcloud compute shared-vpc organizations list-host-projects $ORG_ID

# Attach service projects
# Authenticate to gcloud as a Shared VPC Admin 1
gcloud compute shared-vpc associated-projects add $SERVICE_PROJECT_ID_1A \
    --host-project $HOST_PROJECT_ID_PROD
