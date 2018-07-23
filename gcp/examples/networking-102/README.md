# Terraform implementation of GCP Code Lab - Networking 102
## [Codelabs - Networking 102]

This lab illustrates how to perform some common routing and firewalling tasks on Google Compute Engine. The detailed lab description can be found on the [codelabs link]. The scenarios are implemented in terraform as illustrated in the rest of this guide.

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
Run terraform as follows:
```sh
terraform plan
terraform apply
```

## Step 2
Based on the firewall rule configuration in `vpc.tf` file, SSH sessions to GCP will only be allowed from the public IP of your local machine. After running `terraform plan`, you get a prompt to input the public IP address of your local machine as follows
```sh
$ terraform apply
var.local_public_ip
  public ip address of local machine

  Enter a value: 11.22.33.44
```

## Step 3
From your local machine, SSH into `nat-gw-eu` node's public IP address as follows:
```sh
eval `ssh-agent`
ssh-add <private key>
ssh -A user@<public IP of nat-gw-eu>
```

## Step 4

In the `/etc/squid/whitelisted-domains.txt` file, replace `<# faux-on-prem-svc>` with the public IP address of the `faux-on-prem-svc` instance.
```sh
$ cat /etc/squid/whitelisted-domains.txt
.googleapis.com
# <faux-on-prem-svc-ip>
```

## Step 5
Restart Squid
```sh
sudo service squid restart
```

## Step 6
Exit from the `nat-gw-eu` instance back into your local macine terminal. SSH into `nat-gw-us`:
```sh
ssh -A user@<public IP of nat-gw-us>
```

## Step 7
Add DNAT iptables rule to the faux-on-prem-svc public IP address as shown:
```sh
sudo iptables -A PREROUTING -t nat -i eth0 -d 192.168.30.11 -p tcp --dport 80 -j DNAT --to <faux-on-prem-svc-external-ip>:80
```

## Step 8
Test connectivity from all nodes to ensure they work as explained in the codelabs.

From the nodes, `nat-node-us`, `nat-node-eu` and `nat-node-gcp-eu`, try the following commands:
```sh
$ curl nat-node-w-us
$ curl nat-node-w-eu
$ curl 192.168.30.11
$ curl v4.ifconfig.co
$ curl <faux-on-prem-svc> # public IP address of faux-on-prem-svc instance
$ gsutil ls gs://<any-gcs-bucket-in-your-project>
```

   [Codelabs - Networking 102]: <https://codelabs.developers.google.com/codelabs/cloud-networking-102/>
   [codelabs link]: <https://codelabs.developers.google.com/codelabs/cloud-networking-102/>
