
# launch instance into shared VPC
resource "google_compute_instance" "eu_west1_b" {
  name         = "${var.name}eu-west1-b"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags = ["vm"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.xpn.eu_w1_subnet_10_100_10}"
    address = "10.100.10.10"
    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    email = "${data.terraform_remote_state.prod.vm_prod_service_project_service_account_email}"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# launch instance into shared VPC
resource "google_compute_instance" "eu_west2_b" {
  name         = "${var.name}eu-west2-b"
  machine_type = "g1-small"
  zone         = "europe-west2-b"
  tags = ["vm"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.xpn.eu_w2_subnet_10_100_20}"
    address = "10.100.20.10"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    email = "${data.terraform_remote_state.prod.vm_prod_service_project_service_account_email}"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
