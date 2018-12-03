variable "access_key" {
  description = "account access key"
}

variable "secret_key" {
  description = "account secret key"
}

variable "name" {
  description = "general resource prefix"
  default     = "ks-w2.1-"
}

variable "key_name_eu_west2" {
  description = "Name of the SSH keypair to use in aws us-east1"
}

variable "vpc1_cidr" {
  description = "vpc cidr block"
  default     = "172.18.0.0/18"
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
