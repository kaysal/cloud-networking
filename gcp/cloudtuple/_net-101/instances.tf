# Create intsances
#--------------------------------------
resource "google_compute_instance" "w1_vm" {
  name         = "w1-vm"
  machine_type = "n1-standard-1"
  zone         = "us-west1-b"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.us_west1_s1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "w2_vm" {
  name         = "w2-vm"
  machine_type = "n1-standard-1"
  zone         = "us-west1-b"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.us_west1_s2.name}"
    address    = "10.11.0.100"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "e1_vm" {
  name         = "e1-vm"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.us_east1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "eu1_vm" {
  name         = "eu1-vm"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-d"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.europe_west1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "asia1_vm" {
  name         = "asia1-vm"
  machine_type = "n1-standard-1"
  zone         = "asia-east1-b"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.asia_east1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}
