# vm service account

resource "google_service_account" "vm_gke_service_project" {
  account_id   = "gke-sa"
  display_name = "GKE Node Service Account"
  project      = google_project.gke_service_project.name
}

# iam roles
#----------------------------------------------

# iap

resource "google_project_iam_member" "vm_gke_service_project_iap" {
  project = google_project.gke_service_project.name
  role    = "roles/iap.httpsResourceAccessor"
  member  = "group:gke-grp@cloudtuple.com"
}

# owner

resource "google_project_iam_member" "gke_grp_owner" {
  project = google_project.gke_service_project.name
  role    = "roles/owner"
  member  = "group:gke-grp@cloudtuple.com"
}

resource "google_project_iam_member" "vm_gke_owner" {
  project = google_project.gke_service_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_gke_service_project.email}"
}
