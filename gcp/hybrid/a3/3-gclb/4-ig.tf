
# instance group

resource "google_compute_region_instance_group_manager" "grp" {
  name               = "${var.global.prefix}${local.prefix}grp"
  base_instance_name = "${var.global.prefix}${local.prefix}grp"
  region             = var.gcp.region

  version {
    instance_template = google_compute_instance_template.template.self_link
  }

  named_port {
    name = "http"
    port = "80"
  }
}

# autoscaler

resource "google_compute_region_autoscaler" "as" {
  name   = "${var.global.prefix}${local.prefix}as"
  region = var.gcp.region
  target = google_compute_region_instance_group_manager.grp.self_link

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 2
    cooldown_period = 45

    load_balancing_utilization {
      target = 0.8
    }
  }
}
