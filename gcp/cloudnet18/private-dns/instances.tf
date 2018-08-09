# create bastion instance
resource "google_compute_instance" "demo_test_instance1" {
  name         = "${var.name}demo-test-instance1"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.demo_subnet2.name}"
    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
