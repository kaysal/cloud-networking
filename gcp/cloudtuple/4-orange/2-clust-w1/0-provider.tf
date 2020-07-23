provider "google" {
  project = data.terraform_remote_state.orange.outputs.orange_project_id
}

provider "google-beta" {
  project = data.terraform_remote_state.orange.outputs.orange_project_id
}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/4-orange/2-clust-w1"
  }
}

# kubernetes

data "google_client_config" "default" {
  provider = "google-beta"
}

provider "kubernetes" {
  load_config_file       = false
  host                   = module.gke.endpoint
  token                  = "${data.google_client_config.default.access_token}"
  cluster_ca_certificate = module.gke.cluster_ca_certificate
}
