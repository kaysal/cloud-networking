
variable "prefix" {
  description = "prefix to append before all resources"
  type        = string
}

variable "location" {
  description = "vnet region location"
  type        = string
}

variable "tags" {
  description = "tags for all hub resources"
  type        = map
}

variable "vnet_cidr" {
  description = "vnet cidr"
  type        = any
}

variable "subnet_cidrs" {
  description = "subnets containing workload vm"
  type        = any
}

variable "module_depends_on" {
  type    = any
  default = [""]
}
