resource "google_compute_route" "prod_nat_routes" {
  count = "${var.dmz_mig_size}"
  name = "${var.name}prod-natroute-${count.index}"
  dest_range  = "0.0.0.0/0"
  network = "${google_compute_network.prod.self_link}"
  next_hop_instance = "${lookup(data.google_compute_region_instance_group.natgw_mig.instances[count.index], "instance")}"
  next_hop_instance_zone = "europe-west1-b"
  priority = 500
  tags = ["www"]
}

resource "google_compute_route" "dev_nat_routes" {
  count = "${var.dmz_mig_size}"
  name = "${var.name}dev-natroute-${count.index}"
  dest_range  = "0.0.0.0/0"
  network = "${google_compute_network.dev.self_link}"
  next_hop_instance = "${lookup(data.google_compute_region_instance_group.natgw_mig.instances[count.index], "instance")}"
  next_hop_instance_zone = "europe-west1-b"
  priority = 500
  tags = ["www"]
}
