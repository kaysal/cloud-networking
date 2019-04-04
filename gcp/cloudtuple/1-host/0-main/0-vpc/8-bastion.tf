locals {
  project         = "${data.terraform_remote_state.host.host_project_id}"
  network_project = "${data.terraform_remote_state.host.host_project_id}"
  network         = "${google_compute_network.vpc.self_link}"
  subnetwork      = "${google_compute_subnetwork.apple_eu_w1_10_100_10.self_link}"
  zone            = "europe-west1-c"
}

module "bastion" {
  #source          = "github.com/kaysal/modules.git//gcp/bastion"
  source = "/home/salawu/tf_modules/gcp/bastion"
  name            = "${var.main}bastion"
  hostname        = "bastion.host.cloudtuple.com"
  project         = "${local.project}"
  network_project = "${local.network_project}"
  network         = "${local.network}"
  subnetwork      = "${local.subnetwork}"
  zone            = "europe-west1-c"

  #machine_type             = "f1-micro"
  #list_of_tags             = ["bastion", "gce"]
  #image                    = "debian-cloud/debian-9"
  #disk_type                = "pd-standard"
  #disk_size                = "10"
}

resource "google_dns_record_set" "bastion_public" {
  managed_zone = "${google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "bastion.host.${google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.bastion.bastion_nat_ip}"]
}

resource "google_dns_record_set" "bastion_private" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${google_dns_managed_zone.private_host_cloudtuple.name}"
  name         = "bastion.${google_dns_managed_zone.private_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.bastion.bastion_private_ip}"]
}
