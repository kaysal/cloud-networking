
# Create instances
#--------------------------------------
resource "google_compute_instance" "nat_node_us" {
  name         = "nat-node-us"
  machine_type = "n1-standard-1"
  zone         = "us-central1-f"
  tags = ["nat-us","app"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.nw102_us.name}"
  }
  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-web.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "nat_node_eu" {
  name         = "nat-node-eu"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"
  tags = ["nat-eu","app"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.nw102_eu.name}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-web.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "faux_on_prem_svc" {
  name         = "faux-on-prem-svc"
  machine_type = "n1-standard-1"
  zone         = "us-central1-f"
  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // ephemeral ip
    }
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-web.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "nat_node_gcp_eu" {
  name         = "nat-node-gcp-eu"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"
  tags = ["app"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.nw102_eu.name}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-nat-node-eu.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
