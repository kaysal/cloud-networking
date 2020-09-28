
# depends_on

resource "null_resource" "module_depends_on" {
  triggers = {
    value = length(var.module_depends_on)
  }
}

# interface

resource "azurerm_network_interface" "int_vm" {
  resource_group_name = var.resource_group.name
  name                = "${var.prefix}int-vm"
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "${var.prefix}int-vm"
    subnet_id                     = var.subnet.id
    private_ip_address_allocation = var.static_ip == null ? "Dynamic" : "Static"
    private_ip_address            = var.static_ip == null ? null : var.static_ip
    public_ip_address_id          = var.public_ip.id
  }
}

# vm

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.prefix}vm"
  location              = var.location
  zone                  = var.zone
  resource_group_name   = var.resource_group.name
  network_interface_ids = [azurerm_network_interface.int_vm.id]
  size                  = var.vm_size
  provision_vm_agent    = true
  tags                  = var.tags

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "${var.prefix}vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }

  computer_name  = "${var.prefix}vm"
  admin_username = "adminuser"
}

# add startup script to vm

resource "azurerm_virtual_machine_extension" "vm" {
  name                 = "${var.prefix}script-vm"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  tags                 = var.tags

  settings = <<SETTINGS
    {
        "script": "${var.custom_script}"
    }
SETTINGS
}
