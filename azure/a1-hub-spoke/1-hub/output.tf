
output "hub" {
  value = {
    azurefw = azurerm_firewall.hub_azurefw
    vnet    = azurerm_virtual_network.hub_vnet
    subnet = {
      azurefw = azurerm_subnet.hub_azurefw
    }
  }
  sensitive = "true"
}
