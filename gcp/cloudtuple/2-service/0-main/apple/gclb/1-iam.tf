# Give the apple-grp@ roles/iap.httpsResourceAccessor role
#----------------------------------------------------
resource "google_project_iam_member" "apple_project" {
  project = "${data.terraform_remote_state.apple.apple_service_project_id}"
  role    = "roles/iap.httpsResourceAccessor"
  member  = "group:apple-grp@cloudtuple.com"
}
