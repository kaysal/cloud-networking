
variable "global" {
  description = "variable map holding global config values"
  type        = any
}

variable "spoke2" {
  description = "variable map holding config values for spoke2"
  type        = any
}

variable "hub" {
  description = "variable map holding config values for hub"
  type        = any
}

variable "project_id_hub" {
  description = "project if for hub"
  type        = any
}

variable "project_id_spoke2" {
  description = "project if for spoke2"
  type        = any
}
