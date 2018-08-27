# vm service accounts for all projects
#-----------------------------------------------
resource "google_service_account" "node_gke_service_project" {
  account_id   = "gke-node"
  display_name = "GKE Node Service Account"
  project = "${google_project.gke_service_project.name}"
}

# terraform service accounts
#----------------------------------------------------
resource "google_service_account" "tf_gke_service_project" {
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  project = "${google_project.gke_service_project.name}"
}
