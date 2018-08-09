
# Create multi-zone (regional) managed instance groups
resource "google_compute_region_instance_group_manager" "demo_instance_group" {
  name               = "${var.name}demo-instance-group"
  base_instance_name = "${var.name}demo-mig"
  instance_template  = "${google_compute_instance_template.demo_instance_template.self_link}"
  region       = "europe-west1"

  named_port {
    name = "http"
    port = "80"
  }
}

# Create regional autoscalers
resource "google_compute_region_autoscaler" "demo_instance_group" {
  name   = "${var.name}demo-instance-group"
  region       = "europe-west1"
  target = "${google_compute_region_instance_group_manager.demo_instance_group.self_link}"

  autoscaling_policy = {
    max_replicas    = 3
    min_replicas    = 2
    cooldown_period = 45
  }
}
