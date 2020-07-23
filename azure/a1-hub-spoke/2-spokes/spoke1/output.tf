
output "spoke1" {
  value = {
    vnet = azurerm_virtual_network.spoke1_vnet
    subnet = {
      wload = azurerm_subnet.spoke1_subnet_wload
      jump  = azurerm_subnet.spoke1_subnet_jump
    }
    nsg = {
      jump  = azurerm_network_security_group.spoke1_nsg_jump
      wload = azurerm_network_security_group.spoke1_nsg_wload
    }
  }
  sensitive = "true"
}
