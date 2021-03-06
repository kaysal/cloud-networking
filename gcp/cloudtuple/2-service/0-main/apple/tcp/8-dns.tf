data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  name    = "public-host-cloudtuple"
}

data "google_dns_managed_zone" "private_apple_cloudtuple" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  name    = "private-apple-cloudtuple"
}

