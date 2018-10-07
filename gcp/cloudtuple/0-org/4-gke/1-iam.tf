/*
# give gke-grp@ dns admin role
resource "google_organization_iam_binding" "dns_admin" {
  org_id = "${var.org_id}"
  role    = "roles/dns.admin"
  members = [
    "group:gke-grp@cloudtuple.com",
  ]
}
*/
