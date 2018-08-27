
# Instance template
resource "google_compute_instance_template" "blue_template_eu_w1" {
  name         = "${var.name}blue-template-eu-w1"
  region       = "europe-west1"
  machine_type = "n1-standard-1"
  tags         = ["mig"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.blue_eu_w1_subnet.name}"
    access_config {
      // ephemeral ip
    }
  }

  metadata {
    ssh-keys  = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-blue.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance_template" "blue_template_eu_w2" {
  name         = "${var.name}blue-template-eu-w2"
  region       = "europe-west2"
  machine_type = "n1-standard-1"
  tags         = ["mig"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.blue_eu_w2_subnet.name}"
    access_config {
      // ephemeral ip
    }
  }

  metadata {
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-blue.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}


resource "google_compute_instance_template" "green_template_eu_w1" {
  name         = "${var.name}green-template-eu-w1"
  region       = "europe-west1"
  machine_type = "n1-standard-1"
  tags         = ["mig"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.green_eu_w1_subnet.name}"
    access_config {
      // ephemeral ip
    }
  }

  metadata {
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-green.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance_template" "green_template_eu_w2" {
  name         = "${var.name}green-template-eu-w2"
  region       = "europe-west2"
  machine_type = "n1-standard-1"
  tags         = ["mig"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.green_eu_w2_subnet.name}"
    access_config {
      // ephemeral ip
    }
  }

  metadata {
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-green.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance_template" "dev_template_us_e1" {
  name         = "${var.name}dev-template-us-e1"
  region       = "us-east1"
  machine_type = "n1-standard-1"
  tags         = ["mig"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.dev_us_e1_subnet.name}"
    access_config {
      // ephemeral ip
    }
  }

  metadata {
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-red.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
