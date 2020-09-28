
module "singapore" {
  source            = "../../modules/azure-init"
  prefix            = "${var.azure.prefix}singapore-"
  location          = var.azure.singapore.location
  vnet_cidr         = [var.azure.singapore.vnet_cidr]
  subnet_cidrs      = [var.azure.singapore.subnet_cidr]
  tags              = var.azure.tags
  module_depends_on = [module.london.nsg_association]
}

# output

output "singapore_rg" {
  value     = module.singapore.rg
  sensitive = true
}

output "singapore_ip" {
  value = module.singapore.ip
}

output "singapore_subnet" {
  value     = module.singapore.subnet
  sensitive = true
}
