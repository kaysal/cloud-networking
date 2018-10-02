# Give the apple-grp@ roles/iap.httpsResourceAccessor role
#----------------------------------------------------
resource "google_project_iam_member" "apple_project" {
  project = "${var.project_name}"
  role    = "roles/iap.httpsResourceAccessor"
  member  = "group:apple-grp@cloudtuple.com"
}
