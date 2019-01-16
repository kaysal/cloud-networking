provider "google" {
  project = "${data.terraform_remote_state.gke.gke_service_project_id}"
  credentials = "${var.credentials_file_path}"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.gke.gke_service_project_id}"
  credentials = "${var.credentials_file_path}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/2-service/0-main-demo/gke/1-reg-priv-clust-eu-w1"
  }
}

# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/1-host"
  }
}

data "terraform_remote_state" "gke" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/5-gke"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/0-main-demo/0-vpc"
  }
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}
