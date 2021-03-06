
variable "project_id_hub" {
  description = "project if for hub"
  type        = any
}

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
