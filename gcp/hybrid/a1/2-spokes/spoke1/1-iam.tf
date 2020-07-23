
# service account

resource "google_service_account" "spoke1_sa" {
  account_id   = "${var.global.prefix}${var.spoke1.prefix}sa"
  display_name = "GCE Service Account"
  project      = var.project_id_spoke1
}

# owner role

resource "google_project_iam_member" "spoke1_owner" {
  role   = "roles/owner"
  member = "serviceAccount:${google_service_account.spoke1_sa.email}"
}
