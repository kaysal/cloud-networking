resource "google_compute_instance" "ubuntu_lxc" {
  name  = "ubuntu-lxc"
  machine_type = "n1-standard-1"
  zone = "europe-west1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1604-xenial-v20180814"
      size = 20
    }
  }

  network_interface {
    network = "${google_compute_network.vpc.self_link}"
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
