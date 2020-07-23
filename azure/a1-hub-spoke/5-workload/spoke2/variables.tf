
variable "global" {
  description = "variable map to hold all global config values"
  type        = any
}

variable "spoke2" {
  description = "variable map to hold spoke1 config values"
  type        = any
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "email" {
  description = "enail for action group alerts"
  type        = any
}
