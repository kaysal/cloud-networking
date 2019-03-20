variable "name" {
  description = "prefix to be appended to some resources"
  default     = ""
}

variable "onprem_ip_range" {
  description = "IP range for kubernetes master authorized networks"
}

variable "gcloud_console_ip" {
  description = "IP range for kubernetes master authorized networks"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
