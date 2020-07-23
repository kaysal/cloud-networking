
# service account

resource "google_service_account" "spoke1" {
  account_id   = "${var.global.prefix}spoke1"
  display_name = "GCE Service Account"
}

# owner role

resource "google_project_iam_member" "spoke1_owner" {
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.spoke1.email}"
}
