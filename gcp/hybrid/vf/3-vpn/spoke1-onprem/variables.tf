variable "project_id_hub" {
  description = "project if for hub"
  type        = any
}

variable "project_id_onprem" {
  description = "project if for onprem"
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
