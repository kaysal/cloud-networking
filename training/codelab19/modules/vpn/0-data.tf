data google_compute_address "vpc_demo_gw_ip" {
  count   = "${var.users}"
  name    = "vpc-demo-gw-ip"
  project = "${var.rand}-user${count.index+1}-${var.suffix}"
  region  = "us-central1"
}

data google_compute_address "vpc_onprem_gw_ip" {
  count   = "${var.users}"
  name    = "vpc-onprem-gw-ip"
  project = "${var.rand}-user${count.index+1}-${var.suffix}"
  region  = "us-central1"
}
