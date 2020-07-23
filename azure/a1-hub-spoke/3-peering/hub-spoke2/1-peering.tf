
# hub <---> spoke2

resource "azurerm_virtual_network_peering" "hub_to_spoke2_peering" {
  resource_group_name          = local.rg.hub.name
  name                         = "${var.global.prefix}${var.hub.prefix}hub-to-spoke2-peering"
  virtual_network_name         = local.hub.vnet.name
  remote_virtual_network_id    = local.spoke2.vnet.id
  allow_virtual_network_access = "true"
  allow_forwarded_traffic      = "true"
}

resource "azurerm_virtual_network_peering" "spoke2_to_hub_peering" {
  resource_group_name          = local.rg.spoke2.name
  name                         = "${var.global.prefix}${var.hub.prefix}spoke2-to-hub-peering"
  virtual_network_name         = local.spoke2.vnet.name
  remote_virtual_network_id    = local.hub.vnet.id
  allow_virtual_network_access = "true"
}
