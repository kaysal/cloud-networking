# Bastion host
#============================
resource "google_compute_instance" "bastion_eu_w1" {
  name                      = "${var.name}bastion-eu-w1"
  machine_type              = "g1-small"
  zone                      = "europe-west1-b"
  tags                      = ["gce", "bastion"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
    network_ip = "10.100.10.55"

    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["cloud-platform"]
    email = "${data.terraform_remote_state.apple.vm_apple_service_project_service_account_email}"
  }
}

resource "google_dns_record_set" "bastion_public" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "bastion.gclb.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.bastion_eu_w1.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_dns_record_set" "bastion_private" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "bastion.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.bastion_eu_w1.network_interface.0.network_ip}"]
}

output "bastion_eu_w1" {
  value = "${google_compute_instance.bastion_eu_w1.network_interface.0.access_config.0.nat_ip}"
}

# NEG endpoint VM
#============================
# vm neg 1
#--------------------
resource "google_compute_instance" "neg_eu_w3_vm1" {
  name                      = "${var.name}neg-eu-w3-vm1"
  machine_type              = "g1-small"
  zone                      = "europe-west3-a"
  tags                      = ["gce", "gce-mig-gclb"]
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

resource "google_dns_record_set" "neg_eu_w3_vm1" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "neg1.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.neg_eu_w3_vm1.network_interface.0.network_ip}"]
}

# vm neg2
#--------------------
resource "google_compute_instance" "neg_eu_w3_vm2" {
  name                      = "${var.name}neg-eu-w3-vm2"
  machine_type              = "g1-small"
  zone                      = "europe-west3-a"
  tags                      = ["gce", "gce-mig-gclb"]
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

resource "google_dns_record_set" "neg_eu_w3_vm2" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "neg2.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.neg_eu_w3_vm2.network_interface.0.network_ip}"]
}

# vm neg3
#--------------------
resource "google_compute_instance" "neg_eu_w3_vm3" {
  name                      = "${var.name}neg-eu-w3-vm3"
  machine_type              = "g1-small"
  zone                      = "europe-west3-b"
  tags                      = ["gce", "gce-mig-gclb"]
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

resource "google_dns_record_set" "neg_eu_w3_vm3" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "neg3.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.neg_eu_w3_vm3.network_interface.0.network_ip}"]
}

# sandbox instance
#--------------------
resource "google_compute_instance" "sandbox_us_e1_vm" {
  name                      = "${var.name}sandbox-us-e1-vm"
  machine_type              = "g1-small"
  zone                      = "us-east1-c"
  tags                      = ["gce", "nat-us-east1"]
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

resource "google_dns_record_set" "sandbox_us_e1_vm" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "sandbox.gclb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.sandbox_us_e1_vm.network_interface.0.network_ip}"]
}
