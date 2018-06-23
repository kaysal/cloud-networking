
# Create instances
data "google_compute_subnetwork" "eu_w3b_subnet" {
  name   = "${var.name}-eu-w3b-subnet"
}

resource "google_compute_instance" "eu_w3b_vm1" {
  name         = "${var.name}-eu-w3b-vm1"
  machine_type = "n1-standard-1"
  zone         = "europe-west3-b"
  tags = ["euw3","web"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }
  network_interface {
    subnetwork = "${data.google_compute_subnetwork.eu_w3b_subnet.name}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
