variable "name" {
  description = "prefix to be appended to some resources"
  default     = "nva-"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "gcs_bucket_startup_script" {
  description = "cloud storage startup script file"
  default     = "gs://cloudnet18/networkservices/natgw-startup.sh"
}

variable "mig_size" {
  description = "number of instances in nva managed instance group"
  default = "2"
}
