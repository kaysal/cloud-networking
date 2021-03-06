resource "google_compute_instance_template" "prod_template" {
  name           = "${var.main}prod-template"
  region         = "europe-west1"
  machine_type   = "n1-standard-1"
  can_ip_forward = true
  tags           = ["gce", "mig", "nat-europe-west1"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = data.terraform_remote_state.vpc.outputs.apple_eu_w1_10_100_10
  }

  metadata_startup_script = file("scripts/startup-web-prod.sh")

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

