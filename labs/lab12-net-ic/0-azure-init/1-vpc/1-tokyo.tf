
module "tokyo" {
  source            = "../../modules/azure-init"
  prefix            = "${var.azure.prefix}tokyo-"
  location          = var.azure.tokyo.location
  vnet_cidr         = [var.azure.tokyo.vnet_cidr]
  subnet_cidrs      = [var.azure.tokyo.subnet_cidr]
  tags              = var.azure.tags
  module_depends_on = [""]
}

# output

output "tokyo_rg" {
  value     = module.tokyo.rg
  sensitive = true
}

output "tokyo_ip" {
  value = module.tokyo.ip
}

output "tokyo_subnet" {
  value     = module.tokyo.subnet
  sensitive = true
}
