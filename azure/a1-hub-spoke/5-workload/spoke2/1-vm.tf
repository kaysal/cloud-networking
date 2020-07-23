
# rand
#-------------------------------------------

resource "random_id" "spoke2_storage_account" {
  byte_length = 2

  keepers = {
    resource_group = local.rg.spoke2.name
  }
}

# storage account (for vm boot diagnostics)
#-------------------------------------------

resource "azurerm_storage_account" "spoke2_storage_account" {
  resource_group_name      = local.rg.spoke2.name
  name                     = "spoke2${random_id.spoke2_storage_account.hex}"
  location                 = var.spoke2.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# vm wload
#==========================================

# interface

resource "azurerm_network_interface" "spoke2_int_vm_wload" {
  resource_group_name = local.rg.spoke2.name
  name                = "${var.global.prefix}${var.spoke2.prefix}int-vm-wload"
  location            = var.spoke2.location

  ip_configuration {
    name                          = "${var.global.prefix}${var.spoke2.prefix}int-vm-wload"
    subnet_id                     = local.spoke2.subnet.wload.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.spoke2.vm.wload.ip
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# init

locals {
  spoke2_vm_wload_init = "${base64encode(templatefile("scripts/wload.sh.tpl", {
    VM_HOSTNAME = "${var.spoke2.prefix}wload"
  }))}"
}

# vm

resource "azurerm_virtual_machine" "spoke2_vm_wload" {
  name                          = "${var.global.prefix}${var.spoke2.prefix}vm-wload"
  location                      = var.spoke2.location
  zones                         = ["1"]
  resource_group_name           = local.rg.spoke2.name
  network_interface_ids         = [azurerm_network_interface.spoke2_int_vm_wload.id]
  vm_size                       = var.global.vm_size
  delete_os_disk_on_termination = "true"

  storage_os_disk {
    name              = "${var.global.prefix}${var.spoke2.prefix}disk-vm-wload"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.spoke2.prefix}vm-wload"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file(var.public_key_path)
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.spoke2_storage_account.primary_blob_endpoint
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

resource "azurerm_virtual_machine_extension" "spoke2_extension_vm_wload" {
  name                 = "${var.global.prefix}${var.spoke2.prefix}extension-vm-wload"
  virtual_machine_id   = azurerm_virtual_machine.spoke2_vm_wload.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${local.spoke2_vm_wload_init}"
    }
SETTINGS

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# vm jump
#==========================================

# public ip

resource "azurerm_public_ip" "spoke2_ip_vm_jump" {
  resource_group_name = local.rg.spoke2.name
  name                = "${var.global.prefix}${var.spoke2.prefix}ip-vm-jump"
  location            = var.spoke2.location
  zones               = ["1"]
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

## interface

resource "azurerm_network_interface" "spoke2_int_vm_jump" {
  resource_group_name = local.rg.spoke2.name
  name                = "${var.global.prefix}${var.spoke2.prefix}int-vm-jump"
  location            = var.spoke2.location

  ip_configuration {
    name                          = "${var.global.prefix}${var.spoke2.prefix}int-vm-jump"
    subnet_id                     = local.spoke2.subnet.jump.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.spoke2.vm.jump.ip
    public_ip_address_id          = azurerm_public_ip.spoke2_ip_vm_jump.id
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# init

locals {
  spoke2_vm_jump_init = templatefile("scripts/jump.sh.tpl", {})
}

# vm

resource "azurerm_virtual_machine" "spoke2_vm_jump" {
  name                          = "${var.global.prefix}${var.spoke2.prefix}vm-jump"
  location                      = var.spoke2.location
  zones                         = ["1"]
  resource_group_name           = local.rg.spoke2.name
  network_interface_ids         = [azurerm_network_interface.spoke2_int_vm_jump.id]
  vm_size                       = var.global.vm_size
  delete_os_disk_on_termination = "true"

  storage_os_disk {
    name              = "${var.global.prefix}${var.spoke2.prefix}disk-vm-jump"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.spoke2.prefix}vm-jump"
    admin_username = "azureuser"
    custom_data    = local.spoke2_vm_jump_init
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = file(var.public_key_path)
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.spoke2_storage_account.primary_blob_endpoint
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}
/*
# diagnostics
#-------------------------------------------

# rand

resource "random_id" "spoke2_diagnostics_vm_jump" {
  byte_length = 2

  keepers = {
    resource_group = local.rg.spoke2.name
  }
}

## storage account

resource "azurerm_storage_account" "spoke2_diagnostics_vm_jump" {
  resource_group_name      = local.rg.spoke2.name
  name                     = "spoke2diagvmjump${random_id.spoke2_diagnostics_vm_jump.hex}"
  location                 = var.spoke2.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# diagnostic setting

resource "azurerm_monitor_diagnostic_setting" "spoke2_diagnostics_ip_vm_jump" {
  name                       = "${var.global.prefix}${var.spoke2.prefix}diagnostics-ip-vm-jump"
  target_resource_id         = azurerm_public_ip.spoke2_ip_vm_jump.id
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

# alert
#-------------------------------------------

resource "azurerm_monitor_metric_alert" "spoke2_vm_jump_alert_cpu" {
  name                = "${var.global.prefix}${var.spoke2.prefix}vm-jump-alert-cpu"
  resource_group_name = local.rg.spoke2.name
  scopes              = [azurerm_virtual_machine.spoke2_vm_jump.id]
  description         = "An alert rule to watch the metric Percentage CPU"
  frequency           = "PT1H"
  window_size         = "PT12H"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50
  }

  action {
    action_group_id = local.action_grp.id
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.spoke2.tags.env
    mode  = var.spoke2.tags.mode
  }
}

# workspace linked service
# only azurerm_automation_account can be linked via terraform for now

/*
resource "azurerm_log_analytics_linked_service" "example" {
  resource_group_name = "${azurerm_resource_group.example.name}"
  workspace_name      = "${azurerm_log_analytics_workspace.example.name}"
  resource_id         = "${azurerm_automation_account.example.id}"
}*/
