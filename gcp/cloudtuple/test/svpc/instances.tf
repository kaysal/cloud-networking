
# launch instance into shared vpc
resource "google_compute_instance" "us_east1_b" {
  name         = "${var.name}us-east1-b"
  machine_type = "g1-small"
  zone         = "us-east1-b"
  tags = ["vm"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.xpn.us_e1_subnet_10_120_10}"
    address = "10.120.10.10"
    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    email = "${data.terraform_remote_state.test.vm_test_service_project_service_account_email}"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# launch instance into shared vpc
resource "google_compute_instance" "us_east1_c" {
  name         = "${var.name}us-east1-c"
  machine_type = "g1-small"
  zone         = "us-east1-c"
  tags = ["vm"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.xpn.us_e1_subnet_10_120_10}"
    address = "10.120.10.11"
    #access_config {
      // ephemeral nat ip
    #}
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    email = "${data.terraform_remote_state.test.vm_test_service_project_service_account_email}"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
