# url map
resource "google_compute_url_map" "url_map" {
  name            = "${var.name}url-map"
  default_service = "${google_compute_backend_service.be_svc_orange_80.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  host_rule {
    hosts        = ["pan.cloudtuple.com"]
    path_matcher = "pan"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.be_svc_orange_80.self_link}"
  }

  path_matcher {
    name            = "pan"
    default_service = "${google_compute_backend_service.be_svc_orange_80.self_link}"

    path_rule {
      paths   = ["/app80", "/app80/*"]
      service = "${google_compute_backend_service.be_svc_orange_80.self_link}"
    }

    path_rule {
      paths   = ["/app8080", "/app8080/*"]
      service = "${google_compute_backend_service.be_svc_orange_8080.self_link}"
    }
  }
}
