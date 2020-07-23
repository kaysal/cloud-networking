# storage account
#-----------------------------------

# rand

resource "random_id" "spoke2_nsg_random_id" {
  byte_length = 2

  keepers = {
    resource_group = local.rg.spoke2.name
  }
}

# storage account (diagnostics)

resource "azurerm_storage_account" "spoke2_nsg_diagnostics" {
  resource_group_name      = local.rg.spoke2.name
  name                     = "spoke2nsgdiag${random_id.spoke2_nsg_random_id.hex}"
  location                 = var.global.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# wload
#-----------------------------------

# nsg

resource "azurerm_network_security_group" "spoke2_nsg_wload" {
  resource_group_name = local.rg.spoke2.name
  name                = "${var.global.prefix}${var.spoke2.prefix}nsg-wload"
  location            = var.spoke2.location

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# subnet association

resource "azurerm_subnet_network_security_group_association" "spoke2_nsg_wload" {
  subnet_id                 = azurerm_subnet.spoke2_subnet_wload.id
  network_security_group_id = azurerm_network_security_group.spoke2_nsg_wload.id
}

# jump
#-----------------------------------

# nsg

resource "azurerm_network_security_group" "spoke2_nsg_jump" {
  resource_group_name = local.rg.spoke2.name
  name                = "${var.global.prefix}${var.spoke2.prefix}nsg-jump"
  location            = var.spoke2.location

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# subnet asociation

resource "azurerm_subnet_network_security_group_association" "spoke2_nsg_jump" {
  subnet_id                 = azurerm_subnet.spoke2_subnet_jump.id
  network_security_group_id = azurerm_network_security_group.spoke2_nsg_jump.id
}

# diagonistic

## diagnostic setting

resource "azurerm_monitor_diagnostic_setting" "spoke2_nsg_jump_diag" {
  name               = "${var.global.prefix}${var.spoke2.prefix}nsg-jump-diag"
  target_resource_id = azurerm_network_security_group.spoke2_nsg_jump.id
  storage_account_id = azurerm_storage_account.spoke2_nsg_diagnostics.id

  dynamic "log" {
    for_each = local.diag_nsg.logs
    content {
      category = log.value

      retention_policy {
        enabled = false
      }
    }
  }
}

# data
/*
data "azurerm_monitor_diagnostic_categories" "spoke2_nsg_jump_diag_categories" {
  resource_id = azurerm_network_security_group.spoke2_nsg_jump.id
}

output "spoke2_nsg_jump_diag_categories" {
  value = data.azurerm_monitor_diagnostic_categories.spoke2_nsg_jump_diag_categories
}*/
