
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
  }
}

# subnet

resource "azurerm_subnet" "hub_azurefw" {
  resource_group_name  = local.rg.hub.name
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefix       = var.hub.subnet.azurefw
}
