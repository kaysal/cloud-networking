variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "source_service_accounts" {
  description = "GCE service account"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "networking-101"
}

variable "local_public_ip" {
  description = "public ip address of local machine"
}
