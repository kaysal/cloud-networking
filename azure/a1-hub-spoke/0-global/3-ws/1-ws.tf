
resource "azurerm_log_analytics_workspace" "analytics_wkspace" {
  resource_group_name = local.rg.global.name
  name                = "${var.global.prefix}analytics-ws"
  location            = var.global.location
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.global.tags.env
  }
}

data "azurerm_log_analytics_workspace" "analytics_ws" {
  resource_group_name = local.rg.global.name
  name                = "${var.global.prefix}analytics-ws"
  depends_on          = [azurerm_log_analytics_workspace.analytics_wkspace]
}

/*
resource "azurerm_automation_account" "example" {
  name                = "automation-01"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"

  sku {
    name = "Basic"
  }

  tags = {
    owner = var.global.tags.owner
    lab  = var.global.tags.lab
    env  = var.global.tags.env
  }
}*/
