variable "name" {
  description = "prefix to be appended to some resources"
  default     = "prod-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
