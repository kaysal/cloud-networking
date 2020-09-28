
module "london" {
  source            = "../../modules/azure-init"
  prefix            = "${var.azure.prefix}london-"
  location          = var.azure.london.location
  vnet_cidr         = [var.azure.london.vnet_cidr]
  subnet_cidrs      = [var.azure.london.subnet_cidr]
  tags              = var.azure.tags
  module_depends_on = [module.iowa.nsg_association]
}

# output

output "london_rg" {
  value     = module.london.rg
  sensitive = true
}

output "london_ip" {
  value = module.london.ip
}

output "london_subnet" {
  value     = module.london.subnet
  sensitive = true
}
