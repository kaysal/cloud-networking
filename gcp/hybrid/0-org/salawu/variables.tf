variable "name" {
  description = "prefix to be appended to some resources"
  default     = ""
}

variable "onprem_project" {
  description = "onprem project id"
}

variable "hub_project" {
  description = "hub project id"
}

variable "spoke1_project" {
  description = "spoke1 project id"
}

variable "spoke2_project" {
  description = "spoke2 project id"
}

variable "billing_account_id" {
  description = "billing account ID"
}

variable "org_id" {
  description = "organization ID for personal domain"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}
