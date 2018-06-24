
# Create instances

resource "google_compute_instance" "eu_w1b_ubuntu" {
  name         = "${var.name}-eu-w1b-ubuntu"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  tags = ["euw1","web"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.google_compute_subnetwork.eu_w1b_subnet.name}"

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

resource "google_compute_instance" "eu_w1c_windows" {
  name         = "${var.name}-eu-w1c-windows"
  machine_type = "n1-standard-2"
  zone         = "europe-west1-c"
  tags = ["euw1","web"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2016-dc-v20180612"
    }
  }

  network_interface {
    subnetwork = "${data.google_compute_subnetwork.eu_w1c_subnet.name}"

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
