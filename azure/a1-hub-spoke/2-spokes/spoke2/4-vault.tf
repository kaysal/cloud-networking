
# key vault

resource "azurerm_key_vault" "spoke1_key_vault" {
  resource_group_name         = local.rg.spoke1.name
  name                        = "${var.global.prefix}${var.spoke1.prefix}key-vault"
  location                    = var.spoke1.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions     = ["get", ]
    secret_permissions  = ["get", ]
    storage_permissions = ["get", ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke1.tags.env
    mode  = var.spoke1.tags.mode
  }
}

# diagnostics
#-----------------------------------

# rand

resource "random_id" "spoke1_key_vault_random_id" {
  byte_length = 2

  keepers = {
    resource_group = local.rg.spoke1.name
  }
}

## storage account

resource "azurerm_storage_account" "spoke1_key_vault_diagnostics" {
  resource_group_name      = local.rg.spoke1.name
  name                     = "spoke1vaultdiag${random_id.spoke1_key_vault_random_id.hex}"
  location                 = var.spoke1.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke1.tags.env
    mode  = var.spoke1.tags.mode
  }
}

resource "azurerm_monitor_diagnostic_setting" "spoke1_key_vault_diagnostics" {
  name               = "${var.global.prefix}${var.spoke1.prefix}key-vault-diagnostics"
  target_resource_id = azurerm_key_vault.spoke1_key_vault.id
  storage_account_id = azurerm_storage_account.spoke1_key_vault_diagnostics.id

  log {
    category = "AuditEvent"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}
