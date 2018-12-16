data "google_dns_managed_zone" "cloudtuple_public" {
  name = "cloudtuple"
}

data "google_dns_managed_zone" "cloudtuple_private" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name        = "cloudtuple-private"
}
