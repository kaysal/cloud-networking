
# workload

resource "azurerm_route_table" "spoke2_route_wload" {
  resource_group_name = local.rg.spoke2.name
  name                = "${var.global.prefix}${var.spoke2.prefix}route-wload"
  location            = var.spoke2.location

  route {
    name                   = "${var.spoke2.prefix}default-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = local.azurefw.ip_configuration.0.private_ip_address
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

resource "azurerm_subnet_route_table_association" "spoke2_route_wload" {
  subnet_id      = local.spoke2.subnet.wload.id
  route_table_id = azurerm_route_table.spoke2_route_wload.id
}

# jump

resource "azurerm_route_table" "spoke2_route_jump" {
  resource_group_name = local.rg.spoke2.name
  name                = "${var.global.prefix}${var.spoke2.prefix}route-jump"
  location            = var.spoke2.location

  route {
    name           = "${var.spoke2.prefix}default-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

resource "azurerm_subnet_route_table_association" "spoke2_route_jump" {
  subnet_id      = local.spoke2.subnet.jump.id
  route_table_id = azurerm_route_table.spoke2_route_jump.id
}
