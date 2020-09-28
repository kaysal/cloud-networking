
module "iowa" {
  source            = "../../modules/azure-init"
  prefix            = "${var.azure.prefix}iowa-"
  location          = var.azure.iowa.location
  vnet_cidr         = [var.azure.iowa.vnet_cidr]
  subnet_cidrs      = [var.azure.iowa.subnet_cidr]
  tags              = var.azure.tags
  module_depends_on = [module.tokyo.nsg_association]
}

# output

output "iowa_rg" {
  value     = module.iowa.rg
  sensitive = true
}

output "iowa_ip" {
  value = module.iowa.ip
}

output "iowa_subnet" {
  value     = module.iowa.subnet
  sensitive = true
}
