
# Instance template
resource "google_compute_instance_template" "natgw_template" {
  name         = "${var.name}natgw-template"
  region       = "europe-west1"
  machine_type = "n1-standard-4"
  tags         = ["natgw"]
  can_ip_forward = true

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.dmz_subnet.name}"
    access_config {
      // Ephemeral IP
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.prod_subnet.name}"
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.dev_subnet.name}"
  }

  metadata {
    startup-script-url = "gs://cloudnet18/networkservices/natgw-startup.sh"
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance_template" "prod_template" {
  name         = "${var.name}prod-template"
  region       = "europe-west1"
  machine_type = "n1-standard-1"
  tags         = ["www"]
  can_ip_forward = true

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.prod_subnet.name}"
  }

  metadata {
    startup-script-url = "gs://cloudnet18/networkservices/web-startup.sh"
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance_template" "dev_template" {
  name         = "${var.name}dev-template"
  region       = "europe-west1"
  machine_type = "n1-standard-1"
  tags         = ["www"]
  can_ip_forward = true

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.dev_subnet.name}"
  }

  metadata {
    startup-script-url = "gs://cloudnet18/networkservices/web-startup.sh"
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
