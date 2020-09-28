
module "toronto" {
  source            = "../../modules/azure-init"
  prefix            = "${var.azure.prefix}toronto-"
  location          = var.azure.toronto.location
  vnet_cidr         = [var.azure.toronto.vnet_cidr]
  subnet_cidrs      = [var.azure.toronto.subnet_cidr]
  tags              = var.azure.tags
  module_depends_on = [module.singapore.nsg_association]
}

# output

output "toronto_rg" {
  value     = module.toronto.rg
  sensitive = true
}

output "toronto_ip" {
  value = module.toronto.ip
}

output "toronto_subnet" {
  value     = module.toronto.subnet
  sensitive = true
}
