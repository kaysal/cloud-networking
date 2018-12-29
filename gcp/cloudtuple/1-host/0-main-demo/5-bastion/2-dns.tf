data "google_dns_managed_zone" "cloudtuple_public_host" {
  name = "host-public-cloudtuple"
}

data "google_dns_managed_zone" "cloudtuple_private_host" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name        = "cloudtuple-private-host"
}
