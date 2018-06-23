
# Create instances
data "google_compute_subnetwork" "us_e1b_subnet" {
  name   = "${var.name}-us-e1b-subnet"
}

resource "google_compute_instance" "us_e1b_ubuntu" {
  name         = "${var.name}-us-e1b-ubuntu"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"
  tags = ["use1","web"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }
  
  network_interface {
    subnetwork = "${data.google_compute_subnetwork.us_e1b_subnet.name}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
