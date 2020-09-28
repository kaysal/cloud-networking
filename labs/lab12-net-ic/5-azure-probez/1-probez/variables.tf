
variable "global" {
  description = "variable map to hold all global config values"
  type        = any
}

variable "azure" {
  description = "variable map to hold all azure config values"
  type        = any
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
