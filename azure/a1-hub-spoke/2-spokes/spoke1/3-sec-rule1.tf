
# jump
#-----------------------------------

# ssh external

resource "azurerm_network_security_rule" "spoke1_nsg_rule_ssh_to_jump" {
  resource_group_name         = local.rg.spoke1.name
  name                        = "${var.global.prefix}${var.spoke1.prefix}nsg-rule-ssh-to-jump"
  priority                    = "1001"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = var.spoke1.subnet.jump
  network_security_group_name = azurerm_network_security_group.spoke1_nsg_jump.name
}

# deny all

resource "azurerm_network_security_rule" "spoke1_nsg_rule_all_to_jump" {
  resource_group_name         = local.rg.spoke1.name
  name                        = "${var.global.prefix}${var.spoke1.prefix}nsg-rule-all-to-jump"
  priority                    = "1100"
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.spoke1_nsg_jump.name
}

# wload
#-----------------------------------

# jump to wload: all

resource "azurerm_network_security_rule" "spoke1_nsg_rule_jump_to_wload" {
  resource_group_name         = local.rg.spoke1.name
  name                        = "${var.global.prefix}${var.spoke1.prefix}nsg-rule-jump-to-wload"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.spoke1.subnet.jump
  destination_address_prefix  = var.spoke1.subnet.wload
  network_security_group_name = azurerm_network_security_group.spoke1_nsg_wload.name
}

# spoke2 to wload: all

resource "azurerm_network_security_rule" "spoke1_nsg_rule_spoke2_to_wload" {
  resource_group_name         = local.rg.spoke1.name
  name                        = "${var.global.prefix}${var.spoke1.prefix}nsg-rule-spoke2-to-wload"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.spoke2.subnet.jump
  destination_address_prefix  = var.spoke1.subnet.wload
  network_security_group_name = azurerm_network_security_group.spoke1_nsg_wload.name
}

# hub-azurefw to wload: all

resource "azurerm_network_security_rule" "spoke1_nsg_rule_hub_azurefw_to_wload" {
  resource_group_name         = local.rg.spoke1.name
  name                        = "${var.global.prefix}${var.spoke1.prefix}nsg-rule-hub-azurefw-to-wload"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.hub.subnet.azurefw
  destination_address_prefix  = var.spoke1.subnet.wload
  network_security_group_name = azurerm_network_security_group.spoke1_nsg_wload.name
}

# hub.wload to wload: all

resource "azurerm_network_security_rule" "spoke1_nsg_rule_hub_wload_to_wload" {
  resource_group_name         = local.rg.spoke1.name
  name                        = "${var.global.prefix}${var.spoke1.prefix}nsg-rule-hub-wload-to-wload"
  priority                    = 1004
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = var.hub.subnet.wload
  destination_address_prefix  = var.spoke1.subnet.wload
  network_security_group_name = azurerm_network_security_group.spoke1_nsg_wload.name
}

# deny all

resource "azurerm_network_security_rule" "spoke1_nsg_rule_all_to_wload" {
  resource_group_name         = local.rg.spoke1.name
  name                        = "${var.global.prefix}${var.spoke1.prefix}nsg-rule-all-to-wload"
  priority                    = 1100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.spoke1_nsg_wload.name
}
