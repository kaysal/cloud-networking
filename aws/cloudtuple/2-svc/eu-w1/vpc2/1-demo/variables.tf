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

variable "domain_name" {
  default = "cloudtuples.com"
}
