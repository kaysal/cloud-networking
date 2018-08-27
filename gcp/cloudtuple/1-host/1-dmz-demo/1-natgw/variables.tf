variable "name" {
  description = "prefix to be appended to some resources"
  default     = ""
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

variable "priv_key_path_prod_v6" {
  description = "Path to prod (ipv6) cert private key"
}

variable "crt_path_prod_v6" {
  description = "Path to prod (ipv6) certificate"
}

variable "priv_key_path_dev_v6" {
  description = "Path to dev cert (ipv6) private key"
}

variable "crt_path_dev_v6" {
  description = "Path to dev (ipv6) certificate"
}

variable "dmz_mig_size" {
  description = "number of instances in dmz managed instance group"
  default = "2"
}
