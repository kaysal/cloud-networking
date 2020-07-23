
# service account

resource "google_service_account" "spoke2" {
  account_id   = "${var.global.prefix}spoke2"
  display_name = "GCE Service Account"
  project      = var.project_id_spoke2
}

# owner role

resource "google_project_iam_member" "spoke2_owner" {
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.spoke2.email}"
}
