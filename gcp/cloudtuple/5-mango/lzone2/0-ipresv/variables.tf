variable "project_name" {
  description = "project name"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "mango-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "shared_svc_bgp_ip" {
  default = "169.254.0.1"
}

variable "lzone2_bgp_ip" {
  default = "169.254.0.2"
}
