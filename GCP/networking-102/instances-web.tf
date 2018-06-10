
# Create instances
#--------------------------------------
resource "google_compute_instance" "nat_node_w_us" {
  name         = "nat-node-w-us"
  machine_type = "n1-standard-1"
  zone         = "us-central1-f"
  tags = ["nat-us","web"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.nw102_us.name}"

  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-web.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "nat_node_w_eu" {
  name         = "nat-node-w-eu"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"
  tags = ["nat-eu","web"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.nw102_eu.name}"

  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-web.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}
