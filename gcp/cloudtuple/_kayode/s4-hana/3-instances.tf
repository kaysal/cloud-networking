resource "google_compute_instance" "hana1" {
  name  = "hana1"
  machine_type = "n1-standard-1"
  zone = "europe-west2-b"
  allow_stopping_for_update = true
  tags = ["vm"]

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1604-xenial-v20180814"
      size = 20
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.eu_w2_192_168_1.name}"
    alias_ip_range {
      ip_cidr_range = "192.168.2.1/32"
      subnetwork_range_name = "hana-containers"
    }
    access_config {
      nat_ip = "${google_compute_address.hana1_ip.address}"
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

resource "google_compute_instance" "hana2" {
  name  = "hana2"
  machine_type = "n1-standard-1"
  zone = "europe-west2-b"
  allow_stopping_for_update = true
  tags = ["vm"]

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1604-xenial-v20180814"
      size = 20
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.eu_w2_192_168_1.name}"
    alias_ip_range {
      ip_cidr_range = "192.168.2.2/32"
      subnetwork_range_name = "hana-containers"
    }
    access_config {
      nat_ip = "${google_compute_address.hana2_ip.address}"
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
