
resource "azurerm_monitor_action_group" "action_grp" {
  name                = "${var.global.prefix}action-grp"
  resource_group_name = local.rg.global.name
  short_name          = "${var.global.prefix}actiongrp"

  email_receiver {
    name          = "gmail"
    email_address = var.email
  }

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.global.tags.env
  }
}
