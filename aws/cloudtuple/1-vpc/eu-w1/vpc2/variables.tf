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
  default     = "ks-w1.2-"
}

variable "vpc2_cidr" {
  description = "vpc cidr block"
  default     = "172.17.0.0/16"
}

variable "public_172_17_0" {
  description = "subnet"
  default     = "172.17.0.0/24"
}

variable "private_172_17_10" {
  description = "subnet"
  default     = "172.17.10.0/24"
}

variable "private_172_17_12" {
  description = "subnet"
  default     = "172.17.12.0/24"
}


variable "peer_owner_id" {
  description = "AWS account ID of the owner of the peer VPC"
}

variable "domain_name" {
  default = "cloudtuples.com"
}
