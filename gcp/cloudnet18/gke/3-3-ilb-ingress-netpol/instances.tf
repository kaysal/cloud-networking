
# launch instance into shared VPC
resource "google_compute_instance" "instance" {
  name         = "${var.name}instance"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  allow_stopping_for_update = true
  tags = ["vm"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnet_10_0_4.self_link}"
    access_config {
      // ephemeral nat ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    email = "${data.terraform_remote_state.iam.k8s_node_service_project_service_account_email}"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
