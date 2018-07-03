# Shared VPC in Hybrid Environment

This example illustrates how to setup a BGP dynamic-routing VPN between GCP and AWS. In addition, it shows how to deploy shared VPC in a host project and share amongst service projects.

See scenario [diagram] here.

### Running the Script
---
To run, configure your Google Cloud provider as described in https://www.terraform.io/docs/providers/google/index.html

The variables are located in the `variables.tf` file. You can add a `terraform.tfvars` file to hold your account credentials and secret keys.
Or you can declare the variables when running *terraform apply* as follows:
```sh
terraform apply \
	-var="region=us-central1" \
	-var="region_zone=us-central1-f" \
	-var="project_name=my-project-id-123" \
	-var="credentials_file_path=~/.gcloud/Terraform.json" \
```

## Step 1
Run this script using gcloud `application_default_credentials` on a user account (Organization Admin) that has the following roles at organization level:
- Organization Policy Administrator
- Project Owner
- Folder Admin
- Project Lien Modifier
- Organization Administrator
- Project Creator

Run the following command to sign in as Organization Admin
```sh
gcloud auth application-default login
```

Run Terraform in the GCP directory `./hybrid-svpc/1-gcp-iam/` as follows:
```sh
terraform plan
terraform apply
```
This generates an output of GCP folder and project IDs required in the next step. It also creates user accounts and service accounts for host project and service projects.


## Step 2
Run this script using gcloud `application_default_credentials` on a user account (Shared VPC Admin) that has the following roles at organization level:
- Compute Shared VPC Admin

Run the following command to sign in as Shared VPC Admin
```sh
gcloud auth application-default login
```
This script takes in terraform remote state data inputs from previous step - GCP folders and project IDs.

Run Terraform in the GCP directory `./hybrid-svpc/2-gcp-xpn/`.
This generates an output of GCP external IP addresses that will be used for IPsec VPN tunnels in next step for AWS configuration.

## Step 3
Run Terraform in the directories `./hybrid-svpc/3-aws/eu-w1-vpc1/` and `./hybrid-svpc/3-aws/us-e1-vpc1/`.
You will be prompted to enter the values of the external IP addresses created in Step 2.

When Terraform completes, it will print out the output variables. An example is shown below:
```sh
salawu@salawu:~/Terraform/Multicloud/hybrid-gcp-aws/aws/eu-west1/vpc1$ terraform output
--- eu-w1-vpc1-ubuntu --- = [
    az:        eu-west-1a ,
    priv ip:   172.16.10.208 ,
    pub ip:    54.154.225.139 ,
    priv dns:  ip-172-16-10-208.eu-west-1.compute.internal ,
]
--- eu-w1-vpc1-windows --- = [
    az:        eu-west-1b ,
    priv ip:   172.16.11.221 ,
    pub ip:    54.229.73.211 ,
    priv dns:  ip-172-16-11-221.eu-west-1.compute.internal ,
]
aws_eu_w1_vpc1_cgw1_tunnel1_address = 52.18.195.2
aws_eu_w1_vpc1_cgw1_tunnel1_vgw_inside_address = 169.254.20.81
aws_eu_w1_vpc1_cgw1_tunnel2_address = 54.194.74.164
aws_eu_w1_vpc1_cgw1_tunnel2_vgw_inside_address = 169.254.22.125
gcp_eu_w1_vpc1_cgw1_tunnel1_cgw_inside_address = 169.254.20.82
gcp_eu_w1_vpc1_cgw1_tunnel2_cgw_inside_address = 169.254.22.126
```
All the output values will be used as input in GCP Terraform scripts automatically in next step, so no need to manually copy or transfer these values.

## Step 4
Run this script using gcloud `application_default_credentials` on a user account (Shared VPC Admin) that has the following roles at organization level:
- Compute Shared VPC Admin

Run the following command to sign in as Shared VPC Admin
```sh
gcloud auth application-default login
```
This script takes in terraform remote state data inputs from AWS and GCP IAM created earlier.

Run Terraform in the GCP directory `./hybrid-svpc/4-gcp-xpn-vpn/`.

## Step 5
Before running the service projects, download the keys for the already created service accounts for the `prod-service-project` and `test-service project`. These keys will be used by Terraform REST API calls.
Next, run Terraform in the directories `./hybrid-svpc/5-gcp-service-projects/prod`  and `./hybrid-svpc/5-gcp-service-projects/test`

## Step 6
Run ping tests from instances in GCP to AWS to confirm network connectivity.

[diagram]: <https://storage.googleapis.com/cloud-network-things/multi-cloud/ipsec/shared-vpc-hybrid/hybrid-svpc2.png>
