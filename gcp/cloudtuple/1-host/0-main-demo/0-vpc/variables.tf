variable "name" {
  description = "prefix for resources"
  default     = ""
}

variable "local" {
  description = "prefix for local host resources"
  default     = "local-"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "host_lzone1_bgp_ip" {
  default = "169.254.0.1"
}

variable "host_lzone2_bgp_ip" {
  default = "169.254.1.1"
}
