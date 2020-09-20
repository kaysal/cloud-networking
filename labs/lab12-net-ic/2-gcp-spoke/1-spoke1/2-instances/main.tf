provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../1-vpc/terraform.tfstate"
  }
}

locals {
  default_init = templatefile("scripts/default.sh.tpl", {})
  vpc1         = data.terraform_remote_state.network.outputs.network.vpc1
  subnet = {
    data_eu = data.terraform_remote_state.network.outputs.network.subnet.data_eu
  }
}

# data importer us
#-------------------------------------------

# us

locals {
  ext_db_eu_init = templatefile("scripts/data.sh.tpl", {
    TARGET = var.hub.vpc1.us.ip.db
  })
}

resource "google_compute_instance" "ext_db_eu" {
  name                      = "ext-db-eu"
  machine_type              = var.global.standard_machine
  zone                      = "${var.spoke.vpc_spoke1.eu.region}-c"
  metadata_startup_script   = local.ext_db_eu_init
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.data_eu.self_link
    network_ip = var.spoke.vpc_spoke1.eu.ip.ext_db
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
