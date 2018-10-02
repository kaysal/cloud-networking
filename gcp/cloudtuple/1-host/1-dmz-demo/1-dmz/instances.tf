
resource "google_compute_instance" "siege" {
  name         = "${var.name}siege"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  tags = ["bastion"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.dmz_subnet}"
    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/bastion-startup.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance" "default-standard-vm" {
  name         = "${var.name}default-standard-vm"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    network       = "default"
    access_config {
      // ephemeral nat ip
      network_tier = "STANDARD"
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance" "default-premium-vm" {
  name         = "${var.name}default-premium-vm"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    network       = "default"
    access_config {
      // ephemeral nat ip
      network_tier = "PREMIUM"
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
