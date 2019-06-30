# Instance template
resource "google_compute_instance_template" "blue_template_eu_w1" {
  name         = "${var.main}blue-template-eu-w1"
  region       = "europe-west1"
  machine_type = "f1-micro"
  tags         = ["gce", "mig"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = data.terraform_remote_state.vpc.outputs.apple_eu_w1_10_100_10
  }

  metadata_startup_script = file("scripts/startup-web-blue.sh")

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_template" "blue_template_eu_w2" {
  name         = "${var.main}blue-template-eu-w2"
  region       = "europe-west2"
  machine_type = "f1-micro"
  tags         = ["gce", "mig", "nat-europe-west2"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = data.terraform_remote_state.vpc.outputs.apple_eu_w2_10_150_10
  }

  metadata_startup_script = file("scripts/startup-web-blue.sh")

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_template" "green_template_eu_w1" {
  name         = "${var.main}green-template-eu-w1"
  region       = "europe-west1"
  machine_type = "f1-micro"
  tags         = ["gce", "mig", "nat-europe-west1"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = data.terraform_remote_state.vpc.outputs.apple_eu_w1_10_100_10
  }

  metadata_startup_script = file("scripts/startup-web-green.sh")

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_template" "green_template_eu_w2" {
  name         = "${var.main}green-template-eu-w2"
  region       = "europe-west2"
  machine_type = "f1-micro"
  tags         = ["gce", "mig", "nat-europe-west2"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = data.terraform_remote_state.vpc.outputs.apple_eu_w2_10_150_10
  }

  metadata = {
    ssh-keys = "user:${file(var.public_key_path)}"
  }

  metadata_startup_script = file("scripts/startup-web-green.sh")

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_template" "dev_template_eu_w3" {
  name         = "${var.main}dev-template-eu-w3"
  region       = "europe-west3"
  machine_type = "f1-micro"
  tags         = ["gce", "mig", "nat-europe-west3"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = data.terraform_remote_state.vpc.outputs.apple_eu_w3_10_200_10
  }

  metadata = {
    ssh-keys = "user:${file(var.public_key_path)}"
  }

  metadata_startup_script = file("scripts/startup-web-red.sh")

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

