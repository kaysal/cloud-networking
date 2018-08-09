resource "google_compute_instance" "www" {
  count = "${var.target_pool_count}"
  name  = "www-${count.index}"
  machine_type = "n1-standard-1"
  zone = "europe-west1-b"
  allow_stopping_for_update = true
  tags = ["lb-tag"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.my_custom_subnet.self_link}"
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
