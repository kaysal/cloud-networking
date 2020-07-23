
# vnet

resource "azurerm_virtual_network" "spoke2_vnet" {
  resource_group_name = local.rg.spoke2.name
  name                = "${var.global.prefix}${var.spoke2.prefix}vnet"
  address_space       = [var.spoke2.vnet]
  location            = var.spoke2.location
  dns_servers         = ["8.8.8.8", "8.8.4.4"]

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# subnets

resource "azurerm_subnet" "spoke2_subnet_wload" {
  resource_group_name  = local.rg.spoke2.name
  name                 = "${var.global.prefix}${var.spoke2.prefix}subnet-wload"
  virtual_network_name = azurerm_virtual_network.spoke2_vnet.name
  address_prefix       = var.spoke2.subnet.wload

  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_subnet" "spoke2_subnet_jump" {
  resource_group_name  = local.rg.spoke2.name
  name                 = "${var.global.prefix}${var.spoke2.prefix}subnet-jump"
  virtual_network_name = azurerm_virtual_network.spoke2_vnet.name
  address_prefix       = var.spoke2.subnet.jump

  lifecycle {
    ignore_changes = all
  }
}
