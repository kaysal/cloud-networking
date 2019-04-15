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

variable "asn" {
  default = 64514
}
