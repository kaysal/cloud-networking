# APPLE PROJECT
# netsec-grp@ has DNS admin role for Organisation
# and can create DNS zones in any Org Project
# so you can run 'terraform destroy' on service project without
# deleting the zones and risk getting new name servers
#============================
resource "google_dns_managed_zone" "cloudtuple" {
  project    = "${data.terraform_remote_state.apple.apple_service_project_id}"
  name        = "cloudtuple"
  dns_name    = "cloudtuple.com."
  description = "Second Level Domain"
}
