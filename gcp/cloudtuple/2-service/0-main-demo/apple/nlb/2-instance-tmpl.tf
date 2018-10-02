
# Instance template
resource "google_compute_instance_template" "prod_template_eu_w1" {
  name         = "${var.name}prod-template-eu-w1"
  region       = "europe-west1"
  machine_type = "g1-small"
  tags         = ["gce","gce-mig-nlb","nat-europe-west1"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
    #access_config {
      // ephemeral ip
    #}
  }

  metadata {
    ssh-keys  = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-prod.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
