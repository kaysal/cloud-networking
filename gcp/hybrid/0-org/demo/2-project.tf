
# projects
#==========================================

resource "google_project" "prod_project" {
  name            = "prod-project-k"
  project_id      = "prod-project-k"
  folder_id       = google_folder.prod.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project" "dev_project" {
  name            = "dev-project-k"
  project_id      = "dev-project-k"
  folder_id       = google_folder.dev.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project" "stage_project" {
  name            = "stage-project-k"
  project_id      = "stage-project-k"
  folder_id       = google_folder.stage.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

# service accounts
#==========================================

resource "google_service_account" "vm_prod_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.prod_project.name
}

resource "google_service_account" "vm_dev_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.dev_project.name
}

resource "google_service_account" "vm_stage_project" {
  account_id   = "gce-sa"
  display_name = "GCE Service Account"
  project      = google_project.stage_project.name
}

# iam
#==========================================

# service account project owner
#----------------------------------

resource "google_project_iam_member" "project_owner_vm_prod" {
  project = google_project.prod_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_prod_project.email}"
}

resource "google_project_iam_member" "project_owner_vm_dev" {
  project = google_project.dev_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_dev_project.email}"
}

resource "google_project_iam_member" "project_owner_vm_stage" {
  project = google_project.stage_project.name
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.vm_stage_project.email}"
}
