
# launch instance into shared vpc
resource "google_compute_instance" "us_e1b_svpc" {
  name         = "${var.name}us-e1b-svpc"
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
    subnetwork_project = "${data.terraform_remote_state.iam.netsec_host_project_id}"
    subnetwork = "${data.terraform_remote_state.xpn.us_e1_subnet_10_50_10}"
    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# launch instance into local VPC
resource "google_compute_instance" "us_c1b_local" {
  name         = "${var.name}us-c1b-local"
  machine_type = "g1-small"
  zone         = "us-central1-b"
  tags = ["vm"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.us_c1_subnet_192_168_10.self_link}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance" "us_e1b_nat_svpc" {
  name         = "us-e1b-nat-svpc"
  machine_type = "n1-standard-1"
  zone         = "us-east1-c"
  tags = ["nat"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork_project = "${data.terraform_remote_state.iam.netsec_host_project_id}"
    subnetwork = "${data.terraform_remote_state.xpn.us_e1_subnet_10_50_10}"

    access_config {
      nat_ip = "${google_compute_address.eu_w1_nat_gw_ip.address}"
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-nat.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
  depends_on = ["google_compute_address.eu_w1_nat_gw_ip"]
}
