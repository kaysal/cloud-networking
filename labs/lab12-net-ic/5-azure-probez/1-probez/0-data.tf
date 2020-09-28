
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

# remote state
#--------------------------

# gcp

data "terraform_remote_state" "gcp_hub_vpc1" {
  backend = "local"

  config = {
    path = "../../1-gcp-hub/1-vpc1/1-vpc/terraform.tfstate"
  }
}


data "terraform_remote_state" "vpc3" {
  backend = "local"

  config = {
    path = "../../1-gcp-hub/3-vpc3/1-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "azure_init" {
  backend = "local"

  config = {
    path = "../../0-azure-init/1-vpc/terraform.tfstate"
  }
}

locals {
  gclb_vip           = data.terraform_remote_state.gcp_hub_vpc1.outputs.gclb_vip.address
  gclb_standard_vip  = data.terraform_remote_state.gcp_hub_vpc1.outputs.gclb_standard_vip.address
  mqtt_tcp_proxy_vip = data.terraform_remote_state.gcp_hub_vpc1.outputs.mqtt_tcp_proxy_vip.address

  tokyo_subnet     = data.terraform_remote_state.azure_init.outputs.tokyo_subnet
  iowa_subnet      = data.terraform_remote_state.azure_init.outputs.iowa_subnet
  london_subnet    = data.terraform_remote_state.azure_init.outputs.london_subnet
  singapore_subnet = data.terraform_remote_state.azure_init.outputs.singapore_subnet
  toronto_subnet   = data.terraform_remote_state.azure_init.outputs.toronto_subnet

  tokyo_ip     = data.terraform_remote_state.azure_init.outputs.tokyo_ip
  iowa_ip      = data.terraform_remote_state.azure_init.outputs.iowa_ip
  london_ip    = data.terraform_remote_state.azure_init.outputs.london_ip
  singapore_ip = data.terraform_remote_state.azure_init.outputs.singapore_ip
  toronto_ip   = data.terraform_remote_state.azure_init.outputs.toronto_ip

  tokyo_rg     = data.terraform_remote_state.azure_init.outputs.tokyo_rg
  iowa_rg      = data.terraform_remote_state.azure_init.outputs.iowa_rg
  london_rg    = data.terraform_remote_state.azure_init.outputs.london_rg
  singapore_rg = data.terraform_remote_state.azure_init.outputs.singapore_rg
  toronto_rg   = data.terraform_remote_state.azure_init.outputs.toronto_rg
}
