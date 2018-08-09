
# Instance template
resource "google_compute_instance_template" "demo_instance_template" {
  name         = "${var.name}demo-instance-template"
  region       = "europe-west1"
  machine_type = "n1-standard-1"
  tags         = ["int-ilb"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.demo_subnet1.name}"
    access_config {
      // Ephemeral IP
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
