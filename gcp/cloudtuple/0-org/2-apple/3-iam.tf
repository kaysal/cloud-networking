# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_apple_service_project" {
  project      = google_project.apple_service_project.name
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
}

# iam roles
#----------------------------------------------

# iap

resource "google_project_iam_member" "vm_apple_service_project_iap" {
  project = google_project.apple_service_project.name
  role    = "roles/iap.httpsResourceAccessor"
  member  = "group:apple-grp@cloudtuple.com"
}

# owner

resource "google_project_iam_member" "apple_grp_owner" {
  project = google_project.apple_service_project.name
  role    = "roles/owner"
  member  = "group:apple-grp@cloudtuple.com"
}

resource "google_project_iam_member" "vm_apple_owner" {
  project = google_project.apple_service_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_apple_service_project.email}"
}
