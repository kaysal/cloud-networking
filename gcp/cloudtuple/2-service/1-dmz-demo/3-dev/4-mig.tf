
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
