variable "name" {
  description = "prefix to be appended to some resources"
  default     = "gen-"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "onprem_ip_range" {
  description = "IP range for kubernetes master authorized networks"
}

variable "gcloud_console_ip" {
  description = "IP range for kubernetes master authorized networks"
}
