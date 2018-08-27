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

variable "dmz_mig_size" {
  description = "number of instances in dmz managed instance group"
  default = "2"
}
