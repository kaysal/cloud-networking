variable "access_key" {
  description = "account access key"
}

variable "secret_key" {
  description = "account secret key"
}

variable "name" {
  description = "general resource prefix"
  default     = "shk-"
}

variable "key_name_eu_west2" {
  description = "Name of the SSH keypair to use in aws us-east1"
}

variable "eu_w2_vpc1_cidr" {
  description = "vpc cidr block"
  default     = "172.18.0.0/16"
}

variable "eu_w1_vpc1_172_16_10" {
  description = "subnet"
  default     = "172.16.10.0/24"
}

variable "eu_w2_vpc1_172_18_10" {
  description = "subnet"
  default     = "172.18.10.0/24"
}

variable "preshared_key" {
  description = "preshared key used for tunnels 1 and 2"
}

variable "aws_side_asn" {
  default = "65010"
}

variable "vpcuser16_asn" {
  default = "65020"
}

variable "customer_side_asn" {
  default = "65000"
}
