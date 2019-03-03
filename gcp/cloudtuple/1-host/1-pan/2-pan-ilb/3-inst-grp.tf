resource "google_compute_instance_group" "instance_grp_b" {
  name      = "${var.name}-ig-b"
  instances = ["${google_compute_instance.fw_b.*.self_link}"]
  zone      = "europe-west1-b"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_instance_group" "instance_grp_c" {
  name      = "${var.name}-ig-c"
  instances = ["${google_compute_instance.fw_c.*.self_link}"]
  zone      = "europe-west1-c"

  named_port {
    name = "http"
    port = "80"
  }
}
