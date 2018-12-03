# url map
resource "google_compute_url_map" "url_map" {
  name            = "${var.name}url-map"
  default_service = "${google_compute_backend_service.prod_be_svc.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  host_rule {
    hosts = [
      "gclb.prod.cloudtuple.com",
      "gclb6.prod.cloudtuple.com",
    ]

    path_matcher = "prodpath"
  }

  host_rule {
    hosts = [
      "gclb.dev.cloudtuple.com",
      "gclb6.dev.cloudtuple.com",
    ]

    path_matcher = "devpath"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.prod_be_svc.self_link}"
  }

  path_matcher {
    name            = "prodpath"
    default_service = "${google_compute_backend_service.prod_be_svc.self_link}"
  }

  path_matcher {
    name            = "devpath"
    default_service = "${google_compute_backend_service.dev-be-svc.self_link}"

    path_rule {
      paths   = ["/neg"]
      service = "${google_compute_backend_service.dev-neg-be-svc.self_link}"
    }
  }
}
