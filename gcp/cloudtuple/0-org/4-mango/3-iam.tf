# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_mango_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.mango_project.name
}

# iam roles
#----------------------------------------------

# iap

resource "google_project_iam_member" "vm_mango_iap" {
  project = google_project.mango_project.name
  role    = "roles/iap.httpsResourceAccessor"
  member  = "group:mango-grp@cloudtuple.com"
}

# owner

resource "google_project_iam_member" "mango_grp_owner" {
  project = google_project.mango_project.name
  role    = "roles/owner"
  member  = "group:mango-grp@cloudtuple.com"
}

resource "google_project_iam_member" "vm_mango_owner" {
  project = google_project.mango_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_mango_project.email}"
}
