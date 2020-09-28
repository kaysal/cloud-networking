
# depends_on

resource "null_resource" "module_depends_on" {
  triggers = {
    value = length(var.module_depends_on)
  }
}

# resource group

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}rg"
  location = var.location
  tags     = var.tags
}

# vnet

resource "azurerm_virtual_network" "vnet" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "${var.prefix}vnet"
  address_space       = var.vnet_cidr
  location            = var.location
  tags                = var.tags

  depends_on = [null_resource.module_depends_on]
}

# subnets

resource "azurerm_subnet" "subnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "${var.prefix}subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_cidrs
}

# nsg

resource "azurerm_network_security_group" "nsg" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "${var.prefix}nsg"
  location            = var.location
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "wload1_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_rule" "ssh" {
  resource_group_name         = azurerm_resource_group.rg.name
  name                        = "${var.prefix}ssh"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# public ip address

resource "azurerm_public_ip" "public_ip" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "${var.prefix}pulbic-ip"
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.tags

  depends_on = [null_resource.module_depends_on]
}
