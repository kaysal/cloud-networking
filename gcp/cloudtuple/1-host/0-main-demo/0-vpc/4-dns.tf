# APPLE PROJECT
# netsec-grp@ has DNS admin role for Organisation
# and can create DNS zones in any Org Project
# so you can run 'terraform destroy' on service project without
# deleting the zones and risk getting new name servers
#============================
# Terraform resource N/A
/*
resource "google_dns_managed_zone" "cloudtuple_private" {
  name        = "cloudtuple-private"
  dns_name    = "cloudtuple.com."
  description = "Private Second Level Domain"
}*/

resource "google_dns_managed_zone" "host_public_cloudtuple" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
  name        = "host-public-cloudtuple"
  dns_name    = "cloudtuple.com."
  description = "Host Public Second Level Domain"
}

resource "google_dns_managed_zone" "orange_public_cloudtuple" {
  project    = "${data.terraform_remote_state.orange.orange_service_project_id}"
  name        = "orange-public-cloudtuple"
  dns_name    = "cloudtuple.com."
  description = "Orange Public Second Level Domain"
}

resource "google_dns_managed_zone" "mango_public_cloudtuple" {
  project    = "${data.terraform_remote_state.mango.mango_service_project_id}"
  name        = "mango-public-cloudtuple"
  dns_name    = "cloudtuple.com."
  description = "Mango Public Second Level Domain"
}
