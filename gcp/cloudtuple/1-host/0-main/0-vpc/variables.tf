variable "env" {
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
