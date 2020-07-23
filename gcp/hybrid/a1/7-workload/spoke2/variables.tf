
variable "global" {
  description = "variable map holding global config values"
  type        = any
}

variable "spoke1" {
  description = "variable map holding config values for spoke1"
  type        = any
}

variable "spoke2" {
  description = "variable map holding config values for spoke2"
  type        = any
}

variable "project_id_spoke1" {
  description = "project if for spoke1"
  type        = any
}

variable "project_id_spoke2" {
  description = "project if for spoke2"
  type        = any
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
