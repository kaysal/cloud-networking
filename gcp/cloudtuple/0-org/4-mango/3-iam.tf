# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_mango_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project = "${google_project.mango_project.name}"
}

# IAM roles
#-----------------------------------------------
resource "google_project_iam_binding" "mango_project_iap" {
  project = "${google_project.mango_project.name}"
  role    = "roles/iap.httpsResourceAccessor"

  members = [
    "group:apple-grp@cloudtuple.com",
  ]
}

resource "google_project_iam_binding" "mango_project_owner" {
  project = "${google_project.mango_project.name}"
  role    = "roles/owner"

  members = [
    "group:apple-grp@cloudtuple.com",
    "serviceAccount:${google_service_account.vm_mango_project.email}"
  ]
}
