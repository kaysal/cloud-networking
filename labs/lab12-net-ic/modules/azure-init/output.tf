
output "nsg_association" {
  value = azurerm_subnet_network_security_group_association.wload1_nsg.id
}

output "ip" {
  value = azurerm_public_ip.public_ip
}

output "subnet" {
  value = azurerm_subnet.subnet
}

output "rg" {
  value = azurerm_resource_group.rg
}
