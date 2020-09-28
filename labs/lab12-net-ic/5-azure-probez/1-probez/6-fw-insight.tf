
data "template_file" "fwi" {
  template = file("scripts/fwi-probez.sh.tpl")
  vars = {
    TARGET = data.terraform_remote_state.vpc3.outputs.vm10_public_ip
    COUNT  = 200
  }
}

# public ip address

resource "azurerm_public_ip" "fwi" {
  resource_group_name = local.iowa_rg.name
  name                = "${var.azure.prefix}fwi-pulbic-ip"
  location            = var.azure.iowa.location
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.azure.tags
}

module "fwi" {
  source            = "../../modules/azure-probe"
  prefix            = "${var.azure.prefix}fwi-"
  resource_group    = local.iowa_rg
  location          = var.azure.iowa.location
  subnet            = local.iowa_subnet
  public_ip         = azurerm_public_ip.fwi
  ssh_public_key    = file(var.public_key_path)
  custom_script     = "${base64encode(data.template_file.fwi.rendered)}"
  tags              = var.azure.tags
  module_depends_on = [module.toronto.vm_extension]
}
