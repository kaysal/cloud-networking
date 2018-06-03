# Create firewall rules
#--------------------------------------
resource "google_compute_firewall" "nw101_allow_http" {
  name    = "nw101-allow-http"
  network = "${google_compute_network.networking_101.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# Instance template
#--------------------------------------
resource "google_compute_instance_template" "us_east1_template" {
  name         = "us-east1-template"
  region       = "us-east1"
  machine_type = "n1-standard-1"
  tags         = ["http-server"]

  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.us_east1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    startup-script-url = "${var.gcs_bucket_startup_script}"
    ssh-keys           = "kayode:${file("${var.public_key_path}")}"
  }
}

resource "google_compute_instance_template" "europe_west1_template" {
  name         = "europe-west1-template"
  region       = "europe-west1"
  machine_type = "n1-standard-1"
  tags         = ["http-server"]
  disk {
    source_image = "debian-cloud/debian-9"
    boot         = true
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.europe_west1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    startup-script-url = "${var.gcs_bucket_startup_script}"
    ssh-keys           = "kayode:${file("${var.public_key_path}")}"
  }
}

# Create regional autoscaler for us_east1
# managed instance group
#---------------------------------------
resource "google_compute_region_autoscaler" "autoscaler_us_east1" {
  name   = "autoscaler-us-east1"
  region = "us-east1"
  target = "${google_compute_region_instance_group_manager.us_east1_mig.self_link}"

  autoscaling_policy = {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 45

    load_balancing_utilization {
      target = 0.8
    }
  }
}

# Create multi-zone (regional) managed instance groups
#---------------------------------------
resource "google_compute_region_instance_group_manager" "us_east1_mig" {
  name               = "us-east1-mig"
  base_instance_name = "us-east1-mig"
  instance_template  = "${google_compute_instance_template.us_east1_template.self_link}"
  region             = "us-east1"
}

resource "google_compute_region_instance_group_manager" "europe_west1_mig" {
  name               = "europe-west1-mig"
  base_instance_name = "europe-west1-mig"
  instance_template  = "${google_compute_instance_template.europe_west1_template.self_link}"
  region             = "europe-west1"
  target_size        = "3"
}
