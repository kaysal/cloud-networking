# IAM policy binding for organization.
#-------------------------------
# AVOID using google_organization_iam_policy in TF -
# It will override defaults created on Cloud console
# and your Org Admin account can lock itself out
#-------------------------------
resource "google_organization_iam_member" "shared_vpc_admin_netsec" {
  org_id = "${var.org_id}"
  role   = "roles/compute.xpnAdmin"
  member = "group:netsec-grp@cloudtuple.com"
}

resource "google_organization_iam_member" "shared_vpc_admin_salawu" {
  org_id = "${var.org_id}"
  role   = "roles/compute.xpnAdmin"
  member = "user:salawu@google.com"
}

# dns admin

resource "google_organization_iam_member" "dns_admin" {
  org_id = "${var.org_id}"
  role   = "roles/dns.admin"
  member = "group:netsec-grp@cloudtuple.com"
}
