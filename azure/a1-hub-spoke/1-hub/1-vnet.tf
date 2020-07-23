
# vnet

resource "azurerm_virtual_network" "hub_vnet" {
  resource_group_name = local.rg.hub.name
  name                = "${var.global.prefix}${var.hub.prefix}vnet"
  address_space       = [var.hub.vnet]
  location            = var.hub.location
  dns_servers         = ["8.8.8.8", "8.8.4.4"]

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.hub.tags.env
    mode  = var.hub.tags.mode
  }
}

# subnets

resource "azurerm_subnet" "hub_azurefw" {
  resource_group_name  = local.rg.hub.name
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.hub.subnet.azurefw]
}
/*
resource "azurerm_subnet" "hub_subnet_wload" {
  resource_group_name  = local.rg.hub.name
  name                 = "${var.global.prefix}${var.global.prefix}subnet-wload"
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes       = [var.hub.subnet.wload]

  lifecycle {
    ignore_changes = all
  }
}*/
