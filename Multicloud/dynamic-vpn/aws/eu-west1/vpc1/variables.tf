variable "access_key" {
  description = "account access key"
}

variable "secret_key" {
  description = "account secret key"
}

variable "name" {
  description = "general resource prefix"
  default     = "hydra"
}

variable "key_name_eu_west1" {
  description = "Name of the SSH keypair to use in aws us-east1"
}

variable "vpc1_eu_w1_cidr" {
  description = "The CIDR block for the eu-west1 vpc1"
  default     = "172.16.0.0/16"
}

variable "vpc1_us_e1_cidr" {
  description = "The CIDR block for the us-east1 vpc1"
  default     = "172.18.0.0/16"
}

variable "vpc1_eu_w1a_subnet" {
  default = "172.16.10.0/24"
}

variable "vpc1_eu_w1b_subnet" {
  default = "172.16.20.0/24"
}

variable "vpc1_us_e1b_subnet" {
  default = "172.18.10.0/24"
}

variable "gcp_eu_west1_vpn_gw1_ip" {
  description = "public IP address of remote vpn gw peer"
}

variable "gcp_eu_west1_vpn_gw2_ip" {
  description = "public IP address of remote vpn gw peer"
}

variable "preshared_key" {
  description = "preshared key used for tunnels 1 and 2"
}

variable "admin_password" {
  default = "Windows admin password"
}

variable "aws_side_asn" {
  default = "65010"
}

variable "customer_side_asn" {
  default = "65000"
}
