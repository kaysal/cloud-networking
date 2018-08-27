variable "name" {
  description = "prefix for resources"
  default     = ""
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
