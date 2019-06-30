# bastion host

module "bastion" {
  #source          = "github.com/kaysal/modules.git//gcp/bastion"
  source = "../../../../../../tf_modules/gcp/bastion"
  name            = "${var.env}bastion"
  project         = data.terraform_remote_state.host.outputs.host_project_id
  network_project = data.terraform_remote_state.host.outputs.host_project_id
  network         = google_compute_network.vpc.self_link
  subnetwork      = google_compute_subnetwork.apple_eu_w1_10_100_10.self_link
  zone            = "europe-west1-c"
  ssh_keys        = "user:${file(var.public_key_path)}"
  tags            = ["bastion", "gce"]

  service_account_email = data.terraform_remote_state.host.outputs.vm_host_project_service_account_email
}

resource "google_dns_record_set" "bastion_public" {
  managed_zone = google_dns_managed_zone.public_host_cloudtuple.name
  name         = "bastion.host.${google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300

  rrdatas = [module.bastion.bastion_nat_ip]
}

resource "google_dns_record_set" "bastion_private" {
  project      = data.terraform_remote_state.host.outputs.host_project_id
  managed_zone = google_dns_managed_zone.private_host_cloudtuple.name
  name         = "bastion.${google_dns_managed_zone.private_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300

  rrdatas = [module.bastion.bastion_private_ip]
}

# web server

locals {
  vm_init = templatefile("${path.module}/scripts/web.sh.tpl", {
    VAR = "value"
  })
}

module "cloud_function_web" {
  #source          = "github.com/kaysal/modules.git//gcp/gce-private"
  source = "../../../../../../tf_modules/gcp/gce-private"
  name            = "${var.env}cloud-fnc-web"
  project         = data.terraform_remote_state.host.outputs.host_project_id
  network_project = data.terraform_remote_state.host.outputs.host_project_id
  subnetwork      = google_compute_subnetwork.apple_eu_w1_10_100_10.self_link
  network_ip      = "10.100.10.101"
  zone            = "europe-west1-b"
  tags            = ["gce", "mig"]

  metadata_startup_script = local.vm_init
  service_account_email   = data.terraform_remote_state.host.outputs.vm_host_project_service_account_email
}
