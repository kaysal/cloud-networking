
variable "global" {
  description = "variable map holding global config values"
  type        = any
}

variable "gcp" {
  description = "variable map holding gcp config values"
  type        = any
}

variable "project_id" {
  description = "project if for spoke1"
  type        = any
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
