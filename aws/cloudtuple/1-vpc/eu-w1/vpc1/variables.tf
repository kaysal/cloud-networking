variable "access_key" {
  description = "account access key"
}

variable "secret_key" {
  description = "account secret key"
}

variable "name" {
  description = "general resource prefix"
  default     = "ks-w1.1-"
}

variable "vpc1_cidr" {
  description = "vpc cidr block"
  default     = "172.16.0.0/16"
}

variable "public_172_16_0" {
  description = "subnet"
  default     = "172.16.0.0/24"
}

variable "public_172_16_1" {
  description = "subnet"
  default     = "172.16.1.0/24"
}

variable "private_172_16_10" {
  description = "subnet"
  default     = "172.16.10.0/24"
}

variable "private_172_16_11" {
  description = "subnet"
  default     = "172.16.11.0/24"
}

variable "preshared_key" {
  description = "preshared key used for tunnels 1 and 2"
}

variable "aws_side_asn" {
  default = "65010"
}

variable "customer_side_asn" {
  default = "65000"
}

variable "peer_owner_id" {
  description = "AWS account ID of the owner of the peer VPC"
}

variable "key_name_eu_west1" {
  description = "Name of the SSH keypair to use in aws us-east1"
}

variable "domain_name" {
  default = "cloudtuples.com"
}

# for 'vpc' gcp vpc
variable "vyosa_aws_tunnel_inside_address" {
  default = "169.254.100.1"
}

variable "vyosa_gcp_tunnel_inside_address" {
  default = "169.254.100.2/30"
}

variable "vyosb_aws_tunnel_inside_address" {
  default = "169.254.100.5"
}

variable "vyosb_gcp_tunnel_inside_address" {
  default = "169.254.100.6/30"
}

# for 'untrust' gcp vpc
variable "vyosa_aws_tunnel_inside_address2" {
  default = "169.254.100.9"
}

variable "vyosa_gcp_tunnel_inside_address2" {
  default = "169.254.100.10/30"
}

variable "vyosb_aws_tunnel_inside_address2" {
  default = "169.254.100.13"
}

variable "vyosb_gcp_tunnel_inside_address2" {
  default = "169.254.100.14/30"
}
