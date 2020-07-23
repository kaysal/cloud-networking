
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
  description = "path to public key for ec2 SSH"
}

variable "private_key_path" {
  description = "path to private key for ec2 SSH"
}

variable "project_id_spoke1" {
  description = "project if for spoke1"
  type        = any
}

variable "project_id_spoke2" {
  description = "project if for spoke2"
  type        = any
}

variable "restricted_apis" {
  description = "list of Restrcited Google APIs for Private Google Access"
  type        = list
}
