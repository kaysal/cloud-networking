# Terraform implementation of GCP Code Lab - Networking 101
[Networking 101]

This lab illustrates the basics of VPC, Firewalls, HTTP Load Balancer, and network performance testing.

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

Terraform outputs are created with the public IP addresses of the instances and HTTP load balancer. Example is shown below:

```sh
Outputs:
instance_1_public_ip = [
    "public IP address of instance"
]
instance_2_public_ip = [
    "public IP address of instance 2"
]
```

Use the public IP addresses to access the web servers behind the HTTP load balancer.

   [Networking 101] : https://codelabs.developers.google.com/codelabs/cloud-networking-101
