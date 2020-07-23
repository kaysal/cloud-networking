module "bastion" {
  #source                = "/home/salawu/tf_modules/gcp/bastion?ref=v1.0"
  source                = "../../../../../tf_modules/gcp/bastion"
  name                  = "${var.main}bastion"
  hostname              = "bastion.orange.cloudtuple.com"
  project               = data.terraform_remote_state.orange.outputs.orange_project_id
  network_project       = data.terraform_remote_state.orange.outputs.orange_project_id
  network               = google_compute_network.vpc.self_link
  subnetwork            = google_compute_subnetwork.eu_w1_10_200_20.self_link
  zone                  = "europe-west1-c"
  service_account_email = data.terraform_remote_state.orange.outputs.vm_orange_project_service_account_email
  tags                  = ["bastion", "gce"]
}

resource "google_dns_record_set" "bastion_public" {
  project      = data.terraform_remote_state.host.outputs.host_project_id
  managed_zone = data.google_dns_managed_zone.public_host_cloudtuple.name
  name         = "bastion.orange.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300

  rrdatas = [module.bastion.bastion_nat_ip]
}

resource "google_dns_record_set" "bastion_private" {
  project      = data.terraform_remote_state.orange.outputs.orange_project_id
  managed_zone = google_dns_managed_zone.private_orange_cloudtuple.name
  name         = "bastion.${google_dns_managed_zone.private_orange_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300

  rrdatas = [module.bastion.bastion_private_ip]
}
