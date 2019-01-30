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

resource "google_service_account" "k8s_app_gke_service_project" {
  account_id   = "k8sapp"
  display_name = "k8s cluster App Service Account"
  project = "${google_project.gke_service_project.name}"
}
