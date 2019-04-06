module "bastion" {
  source = "github.com/kaysal/modules.git//gcp/bastion"

  #source                = "/home/salawu/tf_modules/gcp/bastion"
  name                  = "${var.main}bastion"
  hostname              = "bastion.orange.cloudtuple.com"
  project               = "${data.terraform_remote_state.orange.orange_project_id}"
  network_project       = "${data.terraform_remote_state.orange.orange_project_id}"
  network               = "${google_compute_network.vpc.self_link}"
  subnetwork            = "${google_compute_subnetwork.eu_w1_10_200_20.self_link}"
  zone                  = "europe-west1-c"
  service_account_email = "${data.terraform_remote_state.orange.vm_orange_project_service_account_email}"

  #machine_type             = "f1-micro"
  #list_of_tags             = ["bastion", "gce"]
  #image                    = "debian-cloud/debian-9"
  #disk_type                = "pd-standard"
  #disk_size                = "10"
}

resource "google_dns_record_set" "bastion_public" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "bastion.orange.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.bastion.bastion_nat_ip}"]
}

resource "google_dns_record_set" "bastion_private" {
  project      = "${data.terraform_remote_state.orange.orange_project_id}"
  managed_zone = "${google_dns_managed_zone.private_orange_cloudtuple.name}"
  name         = "bastion.${google_dns_managed_zone.private_orange_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.bastion.bastion_private_ip}"]
}
