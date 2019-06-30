module "bastion" {
  source = "github.com/kaysal/modules.git//gcp/bastion"

  #source                = "/home/salawu/tf_modules/gcp/bastion"
  name                  = "${var.main}bastion"
  hostname              = "bastion.mango.cloudtuple.com"
  project               = data.terraform_remote_state.mango.outputs.mango_project_id
  network_project       = data.terraform_remote_state.mango.outputs.mango_project_id
  network               = google_compute_network.vpc.self_link
  subnetwork            = google_compute_subnetwork.eu_w2_10_200_30.self_link
  zone                  = "europe-west2-c"
  service_account_email = data.terraform_remote_state.mango.outputs.vm_mango_project_service_account_email
  #machine_type             = "f1-micro"
  #list_of_tags             = ["bastion", "gce"]
  #image                    = "debian-cloud/debian-9"
  #disk_type                = "pd-standard"
  #disk_size                = "10"
}

resource "google_dns_record_set" "bastion_public" {
  project      = data.terraform_remote_state.host.outputs.host_project_id
  managed_zone = data.google_dns_managed_zone.public_host_cloudtuple.name
  name         = "bastion.main.mango.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [module.bastion.bastion_nat_ip]
}

resource "google_dns_record_set" "bastion_private" {
  project      = data.terraform_remote_state.mango.outputs.mango_project_id
  managed_zone = google_dns_managed_zone.private_mango_cloudtuple.name
  name         = "bastion.main.${google_dns_managed_zone.private_mango_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [module.bastion.bastion_private_ip]
}

