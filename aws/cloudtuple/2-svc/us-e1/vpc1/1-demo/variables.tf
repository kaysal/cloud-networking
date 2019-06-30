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

variable "peer_access_key" {
  description = "account access key"
}

variable "peer_secret_key" {
  description = "account secret key"
}

variable "name" {
  description = "general resource prefix"
  default     = "ks-e1-"
}

variable "bucket_site" {
  default = "alb.cloudtuples.com"
}

variable "bucket_img" {
  default = "cdn.cloudtuples.com"
}

variable "domain_name" {
  default = "cloudtuples.com"
}

