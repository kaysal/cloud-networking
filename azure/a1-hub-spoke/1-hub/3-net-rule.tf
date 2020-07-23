
resource "azurerm_firewall_network_rule_collection" "hub_net_rule_coll1" {
  resource_group_name = local.rg.hub.name
  name                = "${var.global.prefix}${var.hub.prefix}net-rule-coll1"
  azure_firewall_name = azurerm_firewall.hub_azurefw.name
  priority            = "100"
  action              = "Allow"

  rule {
    name              = "dns"
    protocols         = ["UDP", ]
    destination_ports = ["53", ]

    source_addresses = [
      var.spoke1.subnet.wload,
      var.spoke2.subnet.wload
    ]

    destination_addresses = [
      "8.8.8.8",
      "8.8.4.4"
    ]
  }

  rule {
    name              = "httpExt"
    protocols         = ["TCP", ]
    destination_ports = ["80", "8080"]

    source_addresses = ["*"]

    destination_addresses = [
      var.spoke1.subnet.wload,
      var.spoke2.subnet.wload
    ]
  }

  rule {
    name              = "http"
    protocols         = ["TCP", ]
    destination_ports = ["80", "8080", ]

    source_addresses = [
      var.spoke1.subnet.wload,
      var.spoke2.subnet.wload
    ]

    destination_addresses = ["*"]
  }

  rule {
    name              = "https"
    protocols         = ["TCP", ]
    destination_ports = ["443", ]

    source_addresses = [
      var.spoke1.subnet.wload,
      var.spoke2.subnet.wload
    ]

    destination_addresses = ["*"]
  }
}
