variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "cdn-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "gcs_bucket_startup_script" {
  description = "cloud storage startup script file"
  default     = "gs://cloudnet18/networkservices/natgw-startup.sh"
}
