
resource "google_compute_region_instance_group_manager" "mig" {
  name               = "${var.name}mig"
  base_instance_name = "${var.name}mig"
  instance_template  = "${google_compute_instance_template.template.self_link}"
  region       = "europe-west1"

  named_port {
    name = "http"
    port = "80"
  }
}

# Create regional autoscalers
resource "google_compute_region_autoscaler" "mig_autoscaler" {
  name   = "${var.name}mig-autoscaler"
  region       = "europe-west1"
  target = "${google_compute_region_instance_group_manager.mig.self_link}"

  autoscaling_policy = {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.5
    }
  }
}
