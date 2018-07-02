
# Create instances
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
    subnetwork = "${google_compute_subnetwork.eu_w1_subnet_10_10_10.name}"

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
