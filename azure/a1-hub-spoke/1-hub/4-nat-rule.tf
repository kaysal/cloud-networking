
resource "azurerm_firewall_nat_rule_collection" "hub_nat_rule_dnat" {
  resource_group_name = local.rg.hub.name
  name                = "${var.global.prefix}${var.hub.prefix}nat-rule-dnat"
  azure_firewall_name = azurerm_firewall.hub_azurefw.name
  priority            = 100
  action              = "Dnat"

  rule {
    name                  = "spoke1-dnat"
    source_addresses      = ["*", ]
    destination_ports     = ["80", ]
    destination_addresses = [azurerm_public_ip.hub_azurefw_ip.ip_address]
    protocols             = ["TCP", ]
    translated_address    = var.spoke1.vm.wload.ip
    translated_port       = "80"
  }

  rule {
    name                  = "spoke2-dnat"
    source_addresses      = ["*", ]
    destination_ports     = ["8080", ]
    destination_addresses = [azurerm_public_ip.hub_azurefw_ip.ip_address]
    protocols             = ["TCP", ]
    translated_address    = var.spoke2.vm.wload.ip
    translated_port       = "80"
  }
}
