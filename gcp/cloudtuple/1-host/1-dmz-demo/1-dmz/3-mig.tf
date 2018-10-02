
# Create multi-zone (regional) managed instance groups
resource "google_compute_region_instance_group_manager" "mig" {
  name               = "${var.name}mig"
  base_instance_name = "${var.name}mig"
  instance_template  = "${google_compute_instance_template.natgw_template.self_link}"
  region       = "europe-west1"
  target_size        = "${var.mig_size}"
  wait_for_instances = true

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "http-8080"
    port = "8080"
  }
}
