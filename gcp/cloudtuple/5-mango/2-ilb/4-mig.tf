resource "google_compute_region_instance_group_manager" "prod_mig" {
  name               = "${var.name}prod-mig"
  base_instance_name = "${var.name}prod-mig"
  instance_template  = google_compute_instance_template.prod_template.self_link
  region             = "europe-west2"

  named_port {
    name = "http"
    port = "80"
  }
}

# Create regional autoscalers
resource "google_compute_region_autoscaler" "autoscaler_prod_mig" {
  name   = "${var.name}autoscaler-prod-mig"
  region = "europe-west2"
  target = google_compute_region_instance_group_manager.prod_mig.self_link

  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.5
    }
  }
}

