
# Instance template
resource "google_compute_instance_template" "blue_template_eu_w1" {
  name         = "${var.name}blue-template-eu-w1"
  region       = "europe-west1"
  machine_type = "g1-small"
  tags         = ["gce","gce-mig-gclb","nat-europe-west1"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
    #access_config {
      // ephemeral ip
    #}
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
  machine_type = "g1-small"
  tags         = ["gce","gce-mig-gclb","nat-europe-west2"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w2_10_150_10}"
    #access_config {
      // ephemeral ip
    #}
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
  machine_type = "g1-small"
  tags         = ["gce","gce-mig-gclb","nat-europe-west1"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
    #access_config {
      // ephemeral ip
    #}
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
  machine_type = "g1-small"
  tags         = ["gce","gce-mig-gclb","nat-europe-west2"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w2_10_150_10}"
    #access_config {
      // ephemeral ip
    #}
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
  machine_type = "g1-small"
  tags         = ["gce","gce-mig-gclb","nat-us-east1"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_us_e1_10_250_10}"
    #access_config {
      // ephemeral ip
    #}
  }

  metadata {
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup-web-red.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}