resource "google_compute_instance_group" "fw_ig" {
  name      = "${var.name}fw-ig"
  instances = ["${google_compute_instance.fw.*.self_link}"]

  named_port {
    name = "http"
    port = "80"
  }
}
