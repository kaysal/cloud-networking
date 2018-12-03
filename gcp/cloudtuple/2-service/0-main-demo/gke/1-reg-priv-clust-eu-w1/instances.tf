# launch instance into shared VPC
resource "google_compute_instance" "bastion" {
  name         = "${var.name}bastion"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  tags = ["gce","bastion"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.gke_eu_w1_10_0_4}"
    network_ip = "10.0.4.100"
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
