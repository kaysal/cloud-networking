variable "project_name" {
  description = "project name"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "lzone1-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
