# Bastion host
#--------------------
locals {
  project               = "${data.terraform_remote_state.apple.apple_service_project_id}"
  network_project       = "${data.terraform_remote_state.host.host_project_id}"
  network               = "${data.google_compute_network.vpc.self_link}"
  subnetwork            = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
  service_account_email = "${data.terraform_remote_state.apple.vm_apple_service_project_service_account_email}"
  zone                  = "europe-west1-b"
}

module "bastion" {
  source                = "/home/salawu/tf_modules/gcp/bastion"
  name                  = "${var.main}bastion"
  hostname              = "bastion.host.cloudtuple.com"
  project               = "${local.project}"
  network_project       = "${local.network_project}"
  network               = "${local.network}"
  subnetwork            = "${local.subnetwork}"
  zone                  = "${local.zone}"
  service_account_email = "${local.service_account_email}"

  #machine_type             = "f1-micro"
  #list_of_tags             = ["bastion", "gce"]
  #image                    = "debian-cloud/debian-9"
  #disk_type                = "pd-standard"
  #disk_size                = "10"
}

resource "google_dns_record_set" "bastion_public" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "bastion.gclb.apple.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.bastion.bastion_nat_ip}"]
}

resource "google_dns_record_set" "bastion_private" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "bastion.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.bastion.bastion_private_ip}"]
}

# NEG endpoint VM
#--------------------

# vm neg 1

resource "google_compute_instance" "neg_eu_w3_vm1" {
  name                      = "${var.main}neg-eu-w3-vm1"
  machine_type              = "g1-small"
  zone                      = "europe-west3-a"
  tags                      = ["gce", "mig"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w3_10_200_10}"
    network_ip = "10.200.10.11"

    alias_ip_range {
      ip_cidr_range         = "10.0.81.11/32"
      subnetwork_range_name = "neg-range"
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-neg-appx.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# vm neg2

resource "google_compute_instance" "neg_eu_w3_vm2" {
  name                      = "${var.main}neg-eu-w3-vm2"
  machine_type              = "g1-small"
  zone                      = "europe-west3-a"
  tags                      = ["gce", "mig"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w3_10_200_10}"
    network_ip = "10.200.10.22"

    alias_ip_range {
      ip_cidr_range         = "10.0.82.22/32"
      subnetwork_range_name = "neg-range"
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-neg-app1.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# vm neg3

resource "google_compute_instance" "neg_eu_w3_vm3" {
  name                      = "${var.main}neg-eu-w3-vm3"
  machine_type              = "g1-small"
  zone                      = "europe-west3-b"
  tags                      = ["gce", "mig"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w3_10_200_10}"
    network_ip = "10.200.10.33"

    alias_ip_range {
      ip_cidr_range         = "10.0.83.0/24"
      subnetwork_range_name = "neg-range"
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-neg-app1.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}


# sandbox instance

resource "google_compute_instance" "sandbox_us_e1_vm" {
  name                      = "${var.main}sandbox-us-e1-vm"
  machine_type              = "g1-small"
  zone                      = "us-east1-c"
  tags                      = ["gce"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_us_e1_10_250_10}"
    network_ip = "10.250.10.10"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
