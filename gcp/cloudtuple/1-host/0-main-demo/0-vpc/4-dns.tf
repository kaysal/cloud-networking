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

resource "google_dns_managed_zone" "cloudtuple" {
  project    = "${data.terraform_remote_state.apple.apple_service_project_id}"
  name        = "cloudtuple"
  dns_name    = "cloudtuple.com."
  description = "Public Second Level Domain"
}

resource "google_dns_managed_zone" "cloudtuple_orange" {
  project    = "${data.terraform_remote_state.orange.orange_service_project_id}"
  name        = "cloudtuple"
  dns_name    = "cloudtuple.com."
  description = "Public Second Level Domain"
}

resource "google_dns_managed_zone" "cloudtuple_mango" {
  project    = "${data.terraform_remote_state.mango.mango_service_project_id}"
  name        = "cloudtuple"
  dns_name    = "cloudtuple.com."
  description = "Public Second Level Domain"
}
