variable "users" {
  description = "number of users"
}

variable "suffix" {
  description = "suffix"
}

variable "prefix" {
  description = "prefix"
}

variable "rand" {
  description = "random string"
}

variable "dependencies" {
  type = "list"
}

variable "vpc_demo_asn" {
  description = "Local ASN"
}

variable "vpc_onprem_asn" {
  description = "Peer ASN"
}
