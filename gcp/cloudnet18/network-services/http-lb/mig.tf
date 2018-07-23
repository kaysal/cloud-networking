
# Create multi-zone (regional) managed instance groups
resource "google_compute_region_instance_group_manager" "natgw_mig" {
  name               = "${var.name}natgw-mig"
  base_instance_name = "${var.name}natgw-mig"
  instance_template  = "${google_compute_instance_template.natgw_template.self_link}"
  region       = "europe-west1"
  target_size        = "${var.dmz_mig_size}"

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "http-8080"
    port = "8080"
  }
}

resource "google_compute_region_instance_group_manager" "prod_mig" {
  name               = "${var.name}prod-mig"
  base_instance_name = "${var.name}prod-mig"
  instance_template  = "${google_compute_instance_template.prod_template.self_link}"
  region       = "europe-west1"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "dev_mig" {
  name               = "${var.name}dev-mig"
  base_instance_name = "${var.name}dev-mig"
  instance_template  = "${google_compute_instance_template.dev_template.self_link}"
  region       = "europe-west1"

  named_port {
    name = "http"
    port = "80"
  }
}

# Create regional autoscalers
resource "google_compute_region_autoscaler" "autoscaler_prod_mig" {
  name   = "${var.name}autoscaler-prod-mig"
  region       = "europe-west1"
  target = "${google_compute_region_instance_group_manager.prod_mig.self_link}"

  autoscaling_policy = {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_region_autoscaler" "autoscaler_dev_mig" {
  name   = "${var.name}autoscaler-dev-mig"
  region       = "europe-west1"
  target = "${google_compute_region_instance_group_manager.dev_mig.self_link}"

  autoscaling_policy = {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.5
    }
  }
}
