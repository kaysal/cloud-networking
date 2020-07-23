variable "public_key_path" {
  description = "path to public key for ec2 SSH"
}

variable "private_key_path" {
  description = "path to private key for ec2 SSH"
}

variable "env" {
  description = "general resource prefix"
  default     = "ks-w1-"
}
