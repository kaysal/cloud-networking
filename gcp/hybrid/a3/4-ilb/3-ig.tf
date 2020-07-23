
# instance group

resource "google_compute_region_instance_group_manager" "grp1" {
  provider           = google-beta
  name               = "${var.global.prefix}${local.prefix}grp1"
  base_instance_name = "${var.global.prefix}${local.prefix}grp1"
  region             = var.gcp.region

  version {
    instance_template = google_compute_instance_template.template.self_link
    name              = "primary"
  }

  target_size = 2

  named_port {
    name = "http"
    port = "80"
  }
}

# autoscaler
/*
resource "google_compute_region_autoscaler" "as_grp1" {
  name   = "${var.global.prefix}${local.prefix}as-grp1"
  region = var.gcp.region
  target = google_compute_region_instance_group_manager.grp1.self_link

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 2
    cooldown_period = 45

    load_balancing_utilization {
      target = 0.8
    }
  }
}*/
