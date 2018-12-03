resource "google_compute_instance" "vm1" {
  name  = "${var.name}vm1"
  machine_type = "n1-standard-1"
  zone = "europe-west1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/kayode-salawu/global/images/debian-9-multi-ip-subnet"
      size = 20
    }
  }

  network_interface {
    network = "${google_compute_network.vpc.self_link}"
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

resource "google_compute_instance" "vm2" {
  name  = "${var.name}vm2"
  machine_type = "n1-standard-1"
  zone = "europe-west1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/kayode-salawu/global/images/debian-9-multi-ip-subnet"
      size = 20
    }
  }

  network_interface {
    network = "${google_compute_network.vpc.self_link}"
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
