variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "nlb-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "target_pool_count" {
  description = "number of instances in target pool"
  default = "2"
}

variable "preshared_key" {
  description = "ipsec vpn tunnel pre-shared key"
}
