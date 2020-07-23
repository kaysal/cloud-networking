
provider "google" {
  project = var.project_id_onprem
}

provider "google-beta" {
  project = var.project_id_onprem
}
