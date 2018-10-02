# launch instance into shared VPC
resource "google_compute_instance" "bastion_eu_w1" {
  name         = "${var.name}bastion-eu-w1"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags = ["gce","bastion"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
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

resource "google_compute_instance" "vm_eu_w2" {
  name         = "${var.name}vm-eu-w2"
  machine_type = "g1-small"
  zone         = "europe-west2-b"
  tags = ["gce","nat-europe-west2"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w2_10_150_10}"
    #access_config {
      // ephemeral nat ip
    #}
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance" "vm_us_e1" {
  name         = "${var.name}vm-us-e1"
  machine_type = "g1-small"
  zone         = "us-east1-b"
  tags = ["gce","nat-us-east1"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_us_e1_10_250_10}"
    #access_config {
      // ephemeral nat ip
    #}
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
