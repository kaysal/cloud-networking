# url map
resource "google_compute_url_map" "proxy" {
  name            = "${var.name}proxy"
  default_service = "${google_compute_backend_service.prod_backend_service.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  host_rule {
    hosts        = [
      "prod.cloudtuple.com",
      "v6.prod.cloudtuple.com",
    ]
    path_matcher = "prodpath"
  }

  host_rule {
    hosts        = [
      "dev.cloudtuple.com",
      "v6.dev.cloudtuple.com",
    ]
    path_matcher = "devpath"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.prod_backend_service.self_link}"
  }

  path_matcher {
    name            = "prodpath"
    default_service = "${google_compute_backend_service.prod_backend_service.self_link}"
  }

  path_matcher {
    name            = "devpath"
    default_service = "${google_compute_backend_service.dev_backend_service.self_link}"
  }
}
