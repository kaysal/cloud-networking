
# Create instances
resource "google_compute_instance" "us_e1b_ubuntu2" {
  name         = "${var.name}us-e1b-ubuntu2"
  machine_type = "n1-standard-1"
  zone         = "us-east1-c"
  tags = ["vm"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork_project = "${data.terraform_remote_state.iam.netsec_host_project_id}"
    subnetwork = "${data.google_compute_subnetwork.us_e1_subnet_10_50_10.name}"
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
