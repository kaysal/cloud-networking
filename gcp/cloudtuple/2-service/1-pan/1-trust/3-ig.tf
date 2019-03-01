resource "google_compute_instance_group" "ig_b" {
  name = "${var.name}ig-b"
  zone = "europe-west1-b"
  instances = ["${google_compute_instance.web_b.*.self_link}"]

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_instance_group" "ig_c" {
  name = "${var.name}ig-c"
  zone = "europe-west1-c"
  instances = ["${google_compute_instance.web_c.*.self_link}"]

  named_port {
    name = "http"
    port = "80"
  }
}
