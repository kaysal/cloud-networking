# create bastion instance
resource "google_compute_instance" "eu_w1b_bastion" {
  name         = "${var.name}eu-w1b-bastion"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  tags = ["vm"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.eu_w1_subnet_10_10_10.name}"
    access_config {
      // ephemeral nat ip
    }
    alias_ip_range{
      subnetwork_range_name = "${var.name}eu-w1-alias-192-168-100"
      ip_cidr_range= "192.168.100.100/32"
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
