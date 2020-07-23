
# public ip
#---------------------------------

# public ip

resource "azurerm_public_ip" "hub_azurefw_ip" {
  resource_group_name = local.rg.hub.name
  name                = "${var.global.prefix}${var.hub.prefix}azurefw-ip"
  location            = var.hub.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.hub.tags.env
    mode  = var.hub.tags.mode
  }
}

# diagnostic setting

resource "azurerm_monitor_diagnostic_setting" "hub_diagnostics_azurefw_ip" {
  name                       = "${var.global.prefix}${var.hub.prefix}diagnostics-azurefw-ip"
  target_resource_id         = azurerm_public_ip.hub_azurefw_ip.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.analytics_ws.id

  dynamic "log" {
    for_each = local.diag_ip.logs
    content {
      category = log.value

      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = local.diag_ip.metrics
    content {
      category = metric.value

      retention_policy {
        enabled = false
      }
    }
  }
}

# azure firewall
#---------------------------------

resource "azurerm_firewall" "hub_azurefw" {
  resource_group_name = local.rg.hub.name
  name                = "${var.global.prefix}${var.hub.prefix}azurefw"
  location            = var.hub.location

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_azurefw.id
    public_ip_address_id = azurerm_public_ip.hub_azurefw_ip.id
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.hub.tags.env
    mode  = var.hub.tags.mode
  }
}

# diagnostic setting

resource "azurerm_monitor_diagnostic_setting" "hub_diagnostics_azurefw" {
  name                       = "${var.global.prefix}${var.hub.prefix}diagnostics-azurefw"
  target_resource_id         = azurerm_firewall.hub_azurefw.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.analytics_ws.id

  dynamic "log" {
    for_each = local.diag_azurefw.logs
    content {
      category = log.value

      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = local.diag_azurefw.metrics
    content {
      category = metric.value

      retention_policy {
        enabled = false
      }
    }
  }
}
