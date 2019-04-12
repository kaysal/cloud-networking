# internal forwarding rules
resource "google_compute_forwarding_rule" "prod_ilb_fwd_rule" {
  provider = "google-beta"
  name                  = "${var.main}fwd-rule-v4"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = "${google_compute_region_backend_service.prod_ilb.self_link}"
  subnetwork            = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
  ip_address            = "10.100.10.99"
  ip_protocol           = "TCP"
  ports                 = ["80"]
  service_label         = "appleilb"
}

resource "google_dns_record_set" "ilb" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.private_apple_cloudtuple.name}"
  name         = "appw1.ilb.${data.google_dns_managed_zone.private_apple_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_forwarding_rule.prod_ilb_fwd_rule.ip_address}"]
}
