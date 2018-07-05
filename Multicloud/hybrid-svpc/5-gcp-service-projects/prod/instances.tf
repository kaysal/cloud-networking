
# launch instance into shared VPC
resource "google_compute_instance" "eu_w1b_ubuntu" {
  name         = "${var.name}eu-w1b-ubuntu"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  tags = ["vm"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork_project = "${data.terraform_remote_state.iam.netsec_host_project_id}"
    subnetwork = "${data.terraform_remote_state.xpn.eu_w1_subnet_10_10_10}"
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

# launch instance into shared VPC
resource "google_compute_instance" "eu_w2b_ubuntu" {
  name         = "${var.name}eu-w2b-ubuntu"
  machine_type = "n1-standard-1"
  zone         = "europe-west2-b"
  tags = ["vm"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork_project = "${data.terraform_remote_state.iam.netsec_host_project_id}"
    subnetwork = "${data.terraform_remote_state.xpn.eu_w2_subnet_10_10_20}"
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
resource "google_compute_instance" "eu_w3b_ubuntu_local" {
  name         = "${var.name}eu-w3b-ubuntu-local"
  machine_type = "n1-standard-1"
  zone         = "europe-west3-b"
  tags = ["vm"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.eu_w3_subnet_172_16_55.name}"
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
