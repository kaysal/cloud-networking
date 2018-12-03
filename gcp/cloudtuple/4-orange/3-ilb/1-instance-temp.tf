
resource "google_compute_instance_template" "prod_template" {
  name         = "${var.name}prod-template"
  region       = "europe-west2"
  machine_type = "n1-standard-1"
  tags         = ["mig","nat-europe-west2"]
  can_ip_forward = true
  tags = ["mig"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.eu_w2_10_200_20}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-prod.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
