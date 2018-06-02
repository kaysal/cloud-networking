# VPC Setup with 2 Instances Illustrating Basic Network Configuration

This is a basic VPC setup with 2 instances showing network, subnet, firewall rule and route configurations. This scenario was adapted from the script from this Github repo - [Content Based Load Balancing in Google Cloud].

The complete scenario description can be seen at this blog - [GCP - Basic Cloud Network Concepts].

#### Components
---
  1. VPC
  2. 2 x subnets - 10.10.0.0/16 and 192.168.10.0/24
  3. 2 x instances
  4. Instances with metadata scripts that install apache web servers
  5. Security rule allowing:
      - HTTP and SSH access from internet to instances
      - internal communication in the VPC between both subnets
  6. Using custom SSH public keys for access to instances
  7. Terraform outputs for instance public IP addresses

### Running the Script
---
To run, configure your Google Cloud provider as described in https://www.terraform.io/docs/providers/google/index.html

The variables are located in the *variables.tf* file. You can add a *terraform.tfvars* and run terraform as follows:
```sh
terraform plan
terraform apply
```

Or you can declare the variables when running *terraform apply* as follows:
```sh
terraform apply \
	-var="region=us-central1" \
	-var="region_zone=us-central1-f" \
	-var="project_name=my-project-id-123" \
	-var="credentials_file_path=~/.gcloud/Terraform.json" \
```

Terraform outputs are created with the public IP addresses of the instances. Example is shown below:

```sh
Outputs:
instance_1_public_ip = [
    "public IP address of instance"
]
instance_2_public_ip = [
    "public IP address of instance 2"
]
```

Use the public IP addresses for SSH access and to access the web server contents. For the web server contents, type the following in the web browser:
```sh
Instance 1:
instance_1_public_ip

Instance 2:
instance_1_public_ip/video
```

   [Content Based Load Balancing in Google Cloud]: <https://github.com/terraform-providers/terraform-provider-google/tree/master/examples/content-based-load-balancing>
   [GCP - Basic Cloud Network Concepts]: http://www.cloudnetworkthings.com/index.php/cloud-network/25-gcp-vpc
