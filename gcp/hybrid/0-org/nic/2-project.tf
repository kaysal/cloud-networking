
# projects
#==========================================

resource "google_project" "hub_project" {
  name            = var.hub_project
  project_id      = var.hub_project
  folder_id       = google_folder.hub.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project" "spoke1_project" {
  name            = var.spoke1_project
  project_id      = var.spoke1_project
  folder_id       = google_folder.spokes.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project" "spoke2_project" {
  name            = var.spoke2_project
  project_id      = var.spoke2_project
  folder_id       = google_folder.spokes.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

# service accounts
#==========================================

resource "google_service_account" "vm_hub_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.hub_project.name
}

resource "google_service_account" "vm_spoke1_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.spoke1_project.name
}

resource "google_service_account" "vm_spoke2_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.spoke2_project.name
}

# iam
#==========================================

# service account project owner
#----------------------------------

resource "google_project_iam_member" "project_owner_vm_hub" {
  project = google_project.hub_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_hub_project.email}"
}

resource "google_project_iam_member" "project_owner_vm_spoke1" {
  project = google_project.spoke1_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_spoke1_project.email}"
}

resource "google_project_iam_member" "project_owner_vm_spoke2" {
  project = google_project.spoke2_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_spoke2_project.email}"
}
