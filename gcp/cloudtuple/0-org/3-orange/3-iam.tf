# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_orange_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.orange_project.name
}

# iam roles
#----------------------------------------------

# iap

resource "google_project_iam_member" "vm_orange_iap" {
  project = google_project.orange_project.name
  role    = "roles/iap.httpsResourceAccessor"
  member  = "group:orange-grp@cloudtuple.com"
}

# owner

resource "google_project_iam_member" "orange_grp_owner" {
  project = google_project.orange_project.name
  role    = "roles/owner"
  member  = "group:orange-grp@cloudtuple.com"
}

resource "google_project_iam_member" "vm_orange_owner" {
  project = google_project.orange_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_orange_project.email}"
}
