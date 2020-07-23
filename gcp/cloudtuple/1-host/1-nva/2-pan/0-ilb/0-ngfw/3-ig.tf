# ILB Regional Instance group
#================================================
resource "google_compute_instance_group" "ig_b" {
  name      = "${var.name}-ig-b"
  instances = [google_compute_instance.fw_b.self_link]
  zone      = "europe-west1-b"

  named_port {
    name = "http-80"
    port = "80"
  }

  named_port {
    name = "http-8080"
    port = "8080"
  }
}

resource "google_compute_instance_group" "ig_c" {
  name      = "${var.name}-ig-c"
  instances = [google_compute_instance.fw_c.self_link]
  zone      = "europe-west1-c"

  named_port {
    name = "http-80"
    port = "80"
  }

  named_port {
    name = "http-8080"
    port = "8080"
  }
}

