variable "name" {
  description = "prefix to be appended to some resources"
  default     = "alpha-"
}

variable "preshared_key" {
  description = "ipsec vpn tunnel pre-shared key"
}
