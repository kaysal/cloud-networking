
output "spoke2" {
  value = {
    vnet = azurerm_virtual_network.spoke2_vnet
    subnet = {
      wload = azurerm_subnet.spoke2_subnet_wload
      jump  = azurerm_subnet.spoke2_subnet_jump
    }
    nsg = {
      jump  = azurerm_network_security_group.spoke2_nsg_jump
      wload = azurerm_network_security_group.spoke2_nsg_wload
    }
  }
  sensitive = "true"
}
