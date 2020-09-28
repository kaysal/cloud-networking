
variable "resource_group" {
  description = "resource group"
  type        = any
}

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

variable "zone" {
  description = "availability zone for supported regions"
  type        = string
  default     = null
}

variable "subnet" {
  description = "azure subnet"
  type        = any
}

variable "static_ip" {
  description = "optional static ip of vm"
  type        = any
  default     = null
}

variable "public_ip" {
  description = "optional public ip of vm"
  type        = any
  default     = null
}

variable "vm_size" {
  description = "size of vm"
  type        = string
  default     = "Standard_B1s"
}

variable "ssh_public_key" {
  description = "sh public key data"
  type        = string
}

variable "custom_script" {
  description = "custom script"
  type        = any
  default     = ""
}

variable "storage_account" {
  description = "storage account object"
  type        = any
  default     = null
}

variable "module_depends_on" {
  type    = any
  default = [""]
}
