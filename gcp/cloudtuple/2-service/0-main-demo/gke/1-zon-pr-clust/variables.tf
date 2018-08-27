variable "name" {
  description = "prefix to be appended to some resources"
  default     = "zon-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "onprem_ip_range" {
  description = "IP range for kubernetes master authorized networks"
}

variable "gcloud_console_ip" {
  description = "IP range for kubernetes master authorized networks"
}
