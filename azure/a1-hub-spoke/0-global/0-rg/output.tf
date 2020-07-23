
output "rg" {
  value = {
    global = azurerm_resource_group.global
    hub    = azurerm_resource_group.hub
    spoke1 = azurerm_resource_group.spoke1
    spoke2 = azurerm_resource_group.spoke2
  }
  sensitive = "true"
}
