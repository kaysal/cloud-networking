# create bastion instance
resource "google_compute_instance" "prod_bastion" {
  name         = "${var.name}prod-bastion"
  machine_type = "g1-small"
  zone         = "europe-west2-b"
  tags = ["bastion","gce"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.eu_w2_10_200_20}"
    network_ip = "10.200.20.10"
    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/bastion-startup.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
