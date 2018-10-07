# IAM policy binding for organization.
#-------------------------------
# AVOID using google_organization_iam_policy in TF -
# It will override defaults created on Cloud console
# and your Org Admin account can lock itself out
#-------------------------------
resource "google_organization_iam_binding" "shared_vpc_admin" {
  org_id = "${var.org_id}"
  role    = "roles/compute.xpnAdmin"
  members = [
    "group:netsec-grp@cloudtuple.com",
  ]
}

# give netsec-grp@ dns admin role
resource "google_organization_iam_binding" "dns_admin" {
  org_id = "${var.org_id}"
  role    = "roles/dns.admin"
  members = [
    "group:netsec-grp@cloudtuple.com",
  ]
}
