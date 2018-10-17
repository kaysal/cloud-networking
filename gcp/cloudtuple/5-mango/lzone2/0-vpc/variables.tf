variable "project_name" {
  description = "project name"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "lzone2-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "lzone2_bgp_ip" {
  default = "169.254.0.2"
}
