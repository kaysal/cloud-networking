# vm service account
#-----------------------------------------------
resource "google_service_account" "vm_gke_service_project" {
  account_id   = "gke-sa"
  display_name = "GKE Node Service Account"
  project = "${google_project.gke_service_project.name}"
}

# IAM roles
#-----------------------------------------------
resource "google_project_iam_binding" "vm_gke_service_project_iap" {
  project = "${google_project.gke_service_project.name}"
  role    = "roles/iap.httpsResourceAccessor"

  members = [
    "group:apple-grp@cloudtuple.com",
  ]
}

resource "google_project_iam_binding" "vm_gke_service_project_owner" {
  project = "${google_project.gke_service_project.name}"
  role    = "roles/owner"

  members = [
    "group:apple-grp@cloudtuple.com",
    "serviceAccount:${google_service_account.vm_gke_service_project.email}"
  ]
}
