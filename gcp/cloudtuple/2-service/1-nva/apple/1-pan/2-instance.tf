resource "google_compute_instance" "web_b" {
  name                      = "${var.name}-web-b${count.index + 1}"
  zone                      = "europe-west1-b"
  machine_type              = "f1-micro"
  allow_stopping_for_update = true
  count                     = "${var.webserver_count}"
  tags                      = ["${var.name}"]

  labels = {
    instance_grp = "ig"
    fw_zone      = "trust"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.subnet_trust}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance" "web_c" {
  name                      = "${var.name}-web-c${count.index + 1}"
  zone                      = "europe-west1-c"
  machine_type              = "f1-micro"
  allow_stopping_for_update = true
  count                     = "${var.webserver_count}"
  tags                      = ["${var.name}"]

  labels = {
    instance_grp = "ig"
    fw_zone      = "trust"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.subnet_trust}"
  }

  metadata {
    ssh-keys = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
