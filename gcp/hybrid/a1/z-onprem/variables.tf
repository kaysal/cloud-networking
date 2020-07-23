
variable "global" {
  description = "variable map holding global config values"
  type        = any
}

variable "onprem" {
  description = "variable map holding config values for onprem"
  type        = any
}

variable "hub" {
  description = "variable map holding config values for hub"
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

variable "project_id_onprem" {
  description = "project if for onprem"
  type        = any
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
