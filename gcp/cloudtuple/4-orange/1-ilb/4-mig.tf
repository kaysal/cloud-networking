resource "google_compute_region_instance_group_manager" "mig" {
  name               = "${var.name}mig"
  base_instance_name = "${var.name}mig"
  instance_template  = "${google_compute_instance_template.template.self_link}"
  region             = "europe-west1"

  named_port {
    name = "http-80"
    port = "80"
  }

  named_port {
    name = "http-8080"
    port = "8080"
  }
}

# Create regional autoscalers
resource "google_compute_region_autoscaler" "autoscaler_mig" {
  name   = "${var.name}autoscaler-mig"
  region = "europe-west1"
  target = "${google_compute_region_instance_group_manager.mig.self_link}"

  autoscaling_policy = {
    max_replicas    = 3
    min_replicas    = 2
    cooldown_period = 45

    cpu_utilization {
      target = 0.5
    }
  }
}
