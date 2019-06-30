variable "main" {
  description = "prefix to be appended to some resources"
  default     = "ilb-"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

