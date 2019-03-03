variable "name" {
  description = "prefix to be appended to some resources"
  default     = "pan-"
}

variable "preshared_key" {
  description = "ipsec vpn tunnel pre-shared key"
}
