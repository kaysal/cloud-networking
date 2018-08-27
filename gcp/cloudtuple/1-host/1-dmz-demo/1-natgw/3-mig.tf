
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
