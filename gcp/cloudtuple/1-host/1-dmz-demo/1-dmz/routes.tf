data "google_compute_region_instance_group" "mig" {
  self_link = "${google_compute_region_instance_group_manager.mig.instance_group}"
}

resource "google_compute_route" "prod_nat_routes" {
  count = "${var.mig_size}"
  name = "${var.name}prod-natroute-${count.index}"
  dest_range  = "0.0.0.0/0"
  network = "${data.terraform_remote_state.vpc.prod}"
  next_hop_instance = "${lookup(data.google_compute_region_instance_group.mig.instances[count.index], "instance")}"
  next_hop_instance_zone = "europe-west1-b"
  priority = 500
  tags = ["www"]
}

resource "google_compute_route" "dev_nat_routes" {
  count = "${var.mig_size}"
  name = "${var.name}dev-natroute-${count.index}"
  dest_range  = "0.0.0.0/0"
  network = "${data.terraform_remote_state.vpc.dev}"
  next_hop_instance = "${lookup(data.google_compute_region_instance_group.mig.instances[count.index], "instance")}"
  next_hop_instance_zone = "europe-west1-b"
  priority = 500
  tags = ["www"]
}
