variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "http-"
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

variable "dmz_mig_size" {
  description = "number of instances in dmz managed instance group"
  default = "2"
}

variable "private_key_path_prod" {
  description = "Path to prod private key"
}

variable "crt_path_prod" {
  description = "Path to prod certificate"
}

variable "private_key_path_dev" {
  description = "Path to dev private key"
}

variable "crt_path_dev" {
  description = "Path to dev certificate"
}
