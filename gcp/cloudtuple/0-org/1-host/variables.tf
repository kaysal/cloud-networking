variable "name" {
  description = "prefix to be appended to resources"
  default     = ""
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

