
# hub <---> spoke1

resource "azurerm_virtual_network_peering" "hub_to_spoke1_peering" {
  resource_group_name          = local.rg.hub.name
  name                         = "${var.global.prefix}${var.hub.prefix}hub-to-spoke1-peering"
  virtual_network_name         = local.hub.vnet.name
  remote_virtual_network_id    = local.spoke1.vnet.id
  allow_virtual_network_access = "true"
  allow_forwarded_traffic      = "true"
}

resource "azurerm_virtual_network_peering" "spoke1_to_hub_peering" {
  resource_group_name          = local.rg.spoke1.name
  name                         = "${var.global.prefix}${var.hub.prefix}spoke1-to-hub-peering"
  virtual_network_name         = local.spoke1.vnet.name
  remote_virtual_network_id    = local.hub.vnet.id
  allow_virtual_network_access = "true"
}
