
# eu1

resource "google_compute_instance_group" "eu1_ig_b" {
  name      = "${var.global.prefix}${var.hub.prefix}eu1-ig-b"
  instances = [google_compute_instance.eu1_nva1.self_link]
  zone      = "${var.hub.region.eu1}-b"

  named_port {
    name = "http-8080"
    port = "8080"
  }

  named_port {
    name = "http-8081"
    port = "8081"
  }
}

resource "google_compute_instance_group" "eu1_ig_c" {
  name      = "${var.global.prefix}${var.hub.prefix}eu1-ig-c"
  instances = [google_compute_instance.eu1_nvvf.self_link]
  zone      = "${var.hub.region.eu1}-c"

  named_port {
    name = "http-8080"
    port = "8080"
  }

  named_port {
    name = "http-8081"
    port = "8081"
  }
}

# eu2

resource "google_compute_instance_group" "eu2_ig_b" {
  name      = "${var.global.prefix}${var.hub.prefix}eu2-ig-b"
  instances = [google_compute_instance.eu2_nva1.self_link]
  zone      = "${var.hub.region.eu2}-b"

  named_port {
    name = "http-8080"
    port = "8080"
  }

  named_port {
    name = "http-8081"
    port = "8081"
  }
}

resource "google_compute_instance_group" "eu2_ig_c" {
  name      = "${var.global.prefix}${var.hub.prefix}eu2-ig-c"
  instances = [google_compute_instance.eu2_nvvf.self_link]
  zone      = "${var.hub.region.eu2}-c"

  named_port {
    name = "http-8080"
    port = "8080"
  }

  named_port {
    name = "http-8081"
    port = "8081"
  }
}
