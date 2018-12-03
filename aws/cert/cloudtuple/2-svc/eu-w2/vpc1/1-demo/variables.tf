variable "access_key" {
  description = "account access key"
}

variable "secret_key" {
  description = "account secret key"
}

variable "peer_access_key" {
  description = "account access key"
}

variable "peer_secret_key" {
  description = "account secret key"
}

variable "name" {
  description = "general resource prefix"
  default     = "ks-w2-"
}

variable "key_name_eu_west2" {
  description = "Name of the SSH keypair to use in aws us-east1"
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
