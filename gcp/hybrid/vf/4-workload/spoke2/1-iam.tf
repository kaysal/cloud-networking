
# service account

resource "google_service_account" "spoke2_sa" {
  account_id   = "${local.prefix_spoke2}sa"
  display_name = "GCE Service Account"
  project      = var.project_id_spoke2
}

# owner role

resource "google_project_iam_member" "spoke2_owner" {
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.spoke2_sa.email}"
}
