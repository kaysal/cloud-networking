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

variable "key_name_eu_west1" {
  description = "Name of the SSH keypair to use in aws us-east1"
}
