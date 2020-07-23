
# vnet

resource "azurerm_virtual_network" "spoke1_vnet" {
  resource_group_name = local.rg.spoke1.name
  name                = "${var.global.prefix}${var.spoke1.prefix}vnet"
  address_space       = [var.spoke1.vnet]
  location            = var.spoke1.location
  dns_servers         = ["8.8.8.8", "8.8.4.4"]

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke1.tags.env
    mode  = var.spoke1.tags.mode
  }
}

# subnets

resource "azurerm_subnet" "spoke1_subnet_wload" {
  resource_group_name  = local.rg.spoke1.name
  name                 = "${var.global.prefix}${var.spoke1.prefix}subnet-wload"
  virtual_network_name = azurerm_virtual_network.spoke1_vnet.name
  address_prefix       = var.spoke1.subnet.wload

  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_subnet" "spoke1_subnet_jump" {
  resource_group_name  = local.rg.spoke1.name
  name                 = "${var.global.prefix}${var.spoke1.prefix}subnet-jump"
  virtual_network_name = azurerm_virtual_network.spoke1_vnet.name
  address_prefix       = var.spoke1.subnet.jump

  lifecycle {
    ignore_changes = all
  }
}
