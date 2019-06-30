# instance templates

resource "google_compute_instance_template" "template_eu_w1" {
  name         = "${var.name}template-eu-w1"
  region       = "europe-west1"
  machine_type = "f1-micro"
  tags         = ["gce", "mig", "nat-europe-west1"]

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

resource "google_compute_instance_template" "template_eu_w2" {
  name         = "${var.name}template-eu-w2"
  region       = "europe-west2"
  machine_type = "g1-small"
  tags         = ["gce", "mig", "nat-europe-west2"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = data.terraform_remote_state.vpc.outputs.apple_eu_w2_10_150_10
  }

  metadata_startup_script = file("scripts/startup-web-prod.sh")

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

