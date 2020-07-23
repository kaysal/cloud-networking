
variable "project_id_hub" {
  description = "project id for hub"
}

variable "project_number_hub" {
  description = "project number for hub"
}

variable "project_id_spoke1" {
  description = "project id for spoke1"
}

variable "project_number_spoke1" {
  description = "project number for spoke1"
}

variable "project_id_spoke2" {
  description = "project id for spoke2"
}

variable "project_number_spoke2" {
  description = "project number for spoke2"
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

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "restricted_apis" {
  description = "list of Restrcited Google APIs for Private Google Access"
  type        = list
}
