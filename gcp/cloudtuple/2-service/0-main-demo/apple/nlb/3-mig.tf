
# Create multi-zone (regional) managed instance groups
resource "google_compute_region_instance_group_manager" "prod_eu_w1" {
  name               = "${var.name}prod-eu-w1"
  base_instance_name = "${var.name}prod-eu-w1"
  instance_template  = "${google_compute_instance_template.prod_template_eu_w1.self_link}"
  region       = "europe-west1"
  target_size = 2
  target_pools = ["${google_compute_target_pool.prod_target_pool.self_link}"]

  named_port {
    name = "tcp80"
    port = "80"
  }
}
