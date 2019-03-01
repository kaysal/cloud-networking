# internal forwarding rules
resource "google_compute_forwarding_rule" "ilb_fwd_rule" {
  name = "${var.name}ilb-fwd-rule"
  region = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  backend_service = "${google_compute_region_backend_service.be_svc.self_link}"
  subnetwork = "${data.terraform_remote_state.vpc.subnet_prod}"
  ip_address = "10.0.1.10"
  ip_protocol = "TCP"
  ports = ["80"]
}
