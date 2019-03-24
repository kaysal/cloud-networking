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


resource "google_service_account" "gke_php_app_service_account" {
  account_id   = "php-app"
  display_name = "gke php app service account"
  project = "${google_project.gke_service_project.name}"
}
