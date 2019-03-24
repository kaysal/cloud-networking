variable "name" {
  description = "prefix to be appended to some resources"
  default     = ""
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
