
# xpn admin

resource "google_organization_iam_member" "xpn_admin_netsec" {
  org_id = var.org_id
  role   = "roles/compute.xpnAdmin"
  member = "group:netsec-grp@cloudtuple.com"
}

resource "google_organization_iam_member" "xpn_admin_salawu" {
  org_id = var.org_id
  role   = "roles/compute.xpnAdmin"
  member = "user:salawu@google.com"
}

# dns admin

resource "google_organization_iam_member" "dns_admin" {
  org_id = var.org_id
  role   = "roles/dns.admin"
  member = "group:netsec-grp@cloudtuple.com"
}
