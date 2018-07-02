# Dynamic VPN between GCP and AWS

This example illustrates how to setup a BGP dynamic-routing VPN between GCP and AWS. See the diagram for the example on this [blog].

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
Create external IP addresses on GCP with the following names:
- `gcp-eu-west1-vpn-gw1-ip` (region = europe-west1)
- `gcp-eu-west1-vpn-gw2-ip` (region = europe-west1)
- `gcp-us-east1-vpn-gw1-ip` (region = us-east1)

## Step 2
Run Terraform in the directory `./aws/eu-west1/vpc1/eu-west1` as follows:
```sh
terraform plan
terraform apply
```
You will be prompted to enter the values of the external IP addresses created in Step 1.

When Terraform completes, it will print out the output variables. An example is shown below:
```sh
$ terraform output
--- vpc1-eu-w1a-ubuntu --- = [
    az:        eu-west-1a ,
    id:        <instance ID> ,
    priv ip:   172.16.10.15 ,
    pub ip:    34.245.137.63 ,
    priv dns:  ip-172-16-10-15.eu-west-1.compute.internal ,
    key name:  <AWS Region key name>
]
--- vpc1-eu-w1b-windows --- = [
    az:        eu-west-1b ,
    priv ip:   172.16.20.145 ,
    pub ip:    52.209.183.27 ,
    priv dns:  ip-172-16-20-145.eu-west-1.compute.internal ,
    key name:  kayode-ec2-ireland
]
vpc1_gcp_eu_w1_vpn1_tunnel1_address = 54.72.176.220
vpc1_gcp_eu_w1_vpn1_tunnel1_cgw_inside_address = 169.254.21.114
vpc1_gcp_eu_w1_vpn1_tunnel1_vgw_inside_address = 169.254.21.113
vpc1_gcp_eu_w1_vpn1_tunnel2_address = 54.77.158.60
vpc1_gcp_eu_w1_vpn1_tunnel2_cgw_inside_address = 169.254.20.142
vpc1_gcp_eu_w1_vpn1_tunnel2_vgw_inside_address = 169.254.20.141
vpc1_gcp_eu_w1_vpn2_tunnel1_address = 34.246.69.206
vpc1_gcp_eu_w1_vpn2_tunnel1_cgw_inside_address = 169.254.22.142
vpc1_gcp_eu_w1_vpn2_tunnel1_vgw_inside_address = 169.254.22.141
vpc1_gcp_eu_w1_vpn2_tunnel2_address = 52.18.170.158
vpc1_gcp_eu_w1_vpn2_tunnel2_cgw_inside_address = 169.254.22.10
vpc1_gcp_eu_w1_vpn2_tunnel2_vgw_inside_address = 169.254.22.9
```
All the output values will be used as input in GCP Terraform scripts automatically, so no need to manually copy or transfer these values.

## Step 3
Next run Terraform for second AWS region`./aws/eu-west1/vpc1/us-east1` as described in Step 1.

## Step 4
And then run Terraform in directory `./gcp/vpc/` to create the GCP networks, subnets and security rules

## Step 5
Then run Terraform in the following GCP directories to create resources in the 3 regions:
- `./gcp/eu-west1/`
- `./gcp/eu-west3/`
- `./gcp/us-east1/`

## Step 6
Test for ping connectivity from any GCP node in region `europe-west-1` to AWS `eu-west1`. And also test for connectivity from the instance in GCP `us-east-1` to AWS `us-east1`.

[blog]: <http://www.cloudnetworkstuff.com/index.php/2018/06/23/dynamic-routing-vpn-gcp-and-aws/>
