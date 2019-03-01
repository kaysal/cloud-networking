resource "google_compute_route" "trust_routes" {
  count             = "${var.pan_count}"
  name              = "${var.name}trust-route${count.index+1}"
  dest_range        = "0.0.0.0/0"
  network           = "${data.terraform_remote_state.vpc.vpc_trust}"
  next_hop_instance = "${element(google_compute_instance.fw.*.name,count.index)}"
  priority          = 100
  tags              = ["trust"]
}
