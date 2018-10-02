
# Instance template
resource "google_compute_instance_template" "natgw_template" {
  name         = "${var.name}natgw-template"
  region       = "europe-west1"
  machine_type = "n1-standard-4"
  tags         = ["natgw"]
  can_ip_forward = true

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.dmz_subnet}"
    access_config {
      // Ephemeral IP
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.prod_subnet}"
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.dev_subnet}"
  }

  metadata {
    startup-script-url = "gs://cloudnet18/networkservices/natgw-startup.sh"
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
