# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_apple_service_project" {
  project = "${google_project.apple_service_project.name}"
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
}

# IAM roles
#-----------------------------------------------
resource "google_project_iam_binding" "apple_service_project_owner_iap" {
  project = "${google_project.apple_service_project.name}"
  role    = "roles/iap.httpsResourceAccessor"

  members = [
    "group:apple-grp@cloudtuple.com",
  ]
}

resource "google_project_iam_binding" "apple_service_project_owner" {
  project = "${google_project.apple_service_project.name}"
  role    = "roles/owner"

  members = [
    "group:apple-grp@cloudtuple.com",
    "serviceAccount:${google_service_account.vm_apple_service_project.email}"
  ]
}
