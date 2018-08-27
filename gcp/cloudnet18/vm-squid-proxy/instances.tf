
# Create instances
#--------------------------------------
resource "google_compute_instance" "gateway_instance" {
  name         = "gateway-instance"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"
  tags = ["proxy"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.subnet_eu.name}"

    access_config {
      nat_ip = "${google_compute_address.squid_proxy_ext_ip.address}"
    }
  }
  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-squid.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

# Create instances
#--------------------------------------
resource "google_compute_instance" "hidden_instance" {
  name         = "hidden-instance"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"
  tags = ["vm"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.subnet_eu.name}"
  }
  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-vm.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}
