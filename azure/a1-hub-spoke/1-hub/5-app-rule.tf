
resource "azurerm_firewall_application_rule_collection" "hub_app_rule_coll1" {
  name                = "${var.global.prefix}${var.hub.prefix}app-rule-coll1"
  azure_firewall_name = azurerm_firewall.hub_azurefw.name
  resource_group_name = local.rg.hub.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "google"

    source_addresses = [
      var.spoke1.subnet.wload,
      var.spoke2.subnet.wload
    ]

    target_fqdns = ["*.google.com", "*.ubuntu.com"]

    protocol {
      port = "443"
      type = "Https"
    }
    protocol {
      port = "80"
      type = "Http"
    }
  }
}
