
resource "google_compute_instance_template" "dev_template" {
  name         = "${var.name}dev-template"
  region       = "europe-west1"
  machine_type = "n1-standard-1"
  tags         = ["www"]
  can_ip_forward = true

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.dev_subnet}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-dev.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
