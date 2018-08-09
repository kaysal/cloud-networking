variable "name" {
  description = "prefix to be appended to some resources"
  default     = "k8s-"
}

variable "billing_account_id" {
  description = "billing account ID"
}

variable "org_id" {
  description = "organization ID for personal domain"
}
