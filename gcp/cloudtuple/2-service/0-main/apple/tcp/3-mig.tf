# Create multi-zone (regional) managed instance groups
resource "google_compute_region_instance_group_manager" "eu_w1" {
  name               = "${var.name}eu-w1"
  base_instance_name = "${var.name}eu-w1"
  instance_template  = google_compute_instance_template.template_eu_w1.self_link
  region             = "europe-west1"
  target_size        = 1

  named_port {
    name = "tcp110"
    port = "110"
  }
}

resource "google_compute_region_instance_group_manager" "eu_w2" {
  name               = "${var.name}eu-w2"
  base_instance_name = "${var.name}eu-w2"
  instance_template  = google_compute_instance_template.template_eu_w2.self_link
  region             = "europe-west2"
  target_size        = 1

  named_port {
    name = "tcp110"
    port = "110"
  }
}

