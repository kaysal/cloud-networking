variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "dns-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "private_key_path_prod" {
  description = "Path to prod cert private key"
}
