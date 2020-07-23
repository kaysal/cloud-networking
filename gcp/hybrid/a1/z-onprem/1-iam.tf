
# service account

resource "google_service_account" "onprem_sa" {
  account_id   = "${var.global.prefix}onprem-sa"
  display_name = "GCE Service Account"
  project      = var.project_id_onprem
}

# owner role

resource "google_project_iam_member" "onprem_owner" {
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.onprem_sa.email}"
}
