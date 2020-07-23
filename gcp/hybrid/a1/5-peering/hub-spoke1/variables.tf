
variable "global" {
  description = "variable map holding global config values"
  type        = any
}

variable "spoke1" {
  description = "variable map holding config values for spoke1"
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

variable "project_id_spoke1" {
  description = "project if for spoke1"
  type        = any
}
