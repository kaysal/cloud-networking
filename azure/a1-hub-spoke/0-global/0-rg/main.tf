
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "global" {
  name     = "${var.global.prefix}global"
  location = var.global.location

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.global.tags.env
  }
}

resource "azurerm_resource_group" "hub" {
  name     = "${var.global.prefix}hub"
  location = var.global.location

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.global.tags.env
  }
}

resource "azurerm_resource_group" "spoke1" {
  name     = "${var.global.prefix}spoke1"
  location = var.global.location

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.global.tags.env
  }
}

resource "azurerm_resource_group" "spoke2" {
  name     = "${var.global.prefix}spoke2"
  location = var.global.location

  tags = {
    owner = var.global.tags.owner
    lab   = var.global.tags.lab
    env   = var.global.tags.env
  }
}
