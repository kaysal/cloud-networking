variable "access_key" {
  description = "account access key"
}

variable "secret_key" {
  description = "account secret key"
}

variable "public_key_path" {
  description = "path to public key for ec2 SSH"
}

variable "private_key_path" {
  description = "path to private key for ec2 SSH"
}

variable "name" {
  description = "general resource prefix"
  default     = "ks-e1.1-"
}

variable "key_name" {
  description = "Name of the SSH keypair to use in aws us-east1"
}

variable "vpc1_cidr" {
  description = "vpc cidr block"
  default     = "172.18.0.0/16"
}

variable "public_172_18_0" {
  description = "subnet"
  default     = "172.18.0.0/24"
}

variable "public_172_18_1" {
  description = "subnet"
  default     = "172.18.1.0/24"
}

variable "private_172_18_10" {
  description = "subnet"
  default     = "172.18.10.0/24"
}

variable "private_172_18_11" {
  description = "subnet"
  default     = "172.18.11.0/24"
}

variable "private_172_18_12" {
  description = "subnet"
  default     = "172.18.12.0/24"
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

variable "domain_name" {
  default = "cloudtuples.com"
}
