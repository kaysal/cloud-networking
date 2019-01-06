# internal load balancing - backend services
resource "google_compute_region_backend_service" "prod_ilb" {
  name     = "${var.name}prod-ilb"
  region   = "europe-west2"
  protocol = "TCP"

  backend {
    group = "${google_compute_region_instance_group_manager.prod_mig.instance_group}"
  }

  health_checks = ["${google_compute_health_check.ilb_health.self_link}"]
}

# internal forwarding rules
resource "google_compute_forwarding_rule" "prod_ilb_fwd_rule" {
  name                  = "${var.name}prod-ilb-fwd-rule"
  region                = "europe-west2"
  load_balancing_scheme = "INTERNAL"
  backend_service       = "${google_compute_region_backend_service.prod_ilb.self_link}"
  subnetwork            = "${data.terraform_remote_state.vpc.eu_w2_10_200_20}"
  ip_address            = "10.200.20.99"
  ip_protocol           = "TCP"
  ports                 = ["80"]
}

resource "google_dns_record_set" "ilb" {
  managed_zone = "${data.google_dns_managed_zone.private_orange_cloudtuple.name}"
  name         = "app.ilb.${data.google_dns_managed_zone.private_orange_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_forwarding_rule.prod_ilb_fwd_rule.ip_address}"]
}
