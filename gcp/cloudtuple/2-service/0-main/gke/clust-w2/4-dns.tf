data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "public-host-cloudtuple"
}

data "google_dns_managed_zone" "private_gke_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "private-gke-cloudtuple"
}
