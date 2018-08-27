variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = ""
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "gcs_bucket_startup_script" {
  description = "cloud storage startup script file"
  default     = "gs://cloudnet18/networkservices/natgw-startup.sh"
}

variable "priv_key_path_prod" {
  description = "Path to prod cert private key"
}

variable "crt_path_prod" {
  description = "Path to prod certificate"
}

variable "priv_key_path_dev" {
  description = "Path to dev cert private key"
}

variable "crt_path_dev" {
  description = "Path to dev certificate"
}

variable "onprem_ip" {
  description = "onprem bastion host"
}
