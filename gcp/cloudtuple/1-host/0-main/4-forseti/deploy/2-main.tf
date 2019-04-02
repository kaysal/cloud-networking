module "forseti" {
  source  = "git::https://github.com/terraform-google-modules/terraform-google-forseti"
  version = "~> 1.2"

  project_id         = "${data.terraform_remote_state.netsec.forseti_project_id}"
  gsuite_admin_email = "${var.gsuite_admin_email}"
  domain             = "${var.domain}"
  org_id             = "${var.org_id}"

  # Shared VPC
  #network         = "${var.network}"
  #network_project = "${var.network_project}"
  #subnetwork      = "${var.subnetwork}"
  #network = "${google_compute_network.vpc.self_link}"
  #subnetwork = "${google_compute_subnetwork.subnet.self_link}"

  # Regions
  #cloudsql_region         = "locals.region"
  #client_region           = "locals.region"
  #server_region           = "locals.region"
  #bucket_cai_location     = "locals.region"
  #storage_bucket_location = "locals.region"
}
/*
locals {
  region = "europe-west1"
}*/
