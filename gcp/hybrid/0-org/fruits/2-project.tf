
# projects
#==========================================

resource "google_project" "apple_project" {
  name            = "apple-project-k"
  project_id      = "apple-project-k"
  folder_id       = google_folder.apple.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project" "orange_project" {
  name            = "orange-project-k"
  project_id      = "orange-project-k"
  folder_id       = google_folder.orange.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project" "mango_project" {
  name            = "mango-project-k"
  project_id      = "mango-project-k"
  folder_id       = google_folder.mango.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

# service accounts
#==========================================

resource "google_service_account" "vm_apple_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.apple_project.name
}

resource "google_service_account" "vm_orange_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.orange_project.name
}

resource "google_service_account" "vm_mango_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.mango_project.name
}

# iam
#==========================================

# service account project owner
#----------------------------------

resource "google_project_iam_member" "project_owner_vm_apple" {
  project = google_project.apple_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_apple_project.email}"
}

resource "google_project_iam_member" "project_owner_vm_orange" {
  project = google_project.orange_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_orange_project.email}"
}

resource "google_project_iam_member" "project_owner_vm_mango" {
  project = google_project.mango_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_mango_project.email}"
}
