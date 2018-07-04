
provider "google" {
  project    = "${var.name}${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/5-gcp-service-projects/prod/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "iam" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/1-gcp-org-iam/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

data "google_compute_subnetwork" "eu_w1_subnet_10_10_10" {
  name     = "${var.name}eu-w1-subnet-10-10-10"
  project  = "${data.terraform_remote_state.iam.netsec_host_project_id}"
  region   = "europe-west1"
}

data "google_compute_subnetwork" "eu_w2_subnet_10_10_20" {
  name     = "${var.name}eu-w2-subnet-10-10-20"
  project  = "${data.terraform_remote_state.iam.netsec_host_project_id}"
  region   = "europe-west2"
}

data "google_compute_subnetwork" "us_e1_subnet_10_50_10" {
  name     = "${var.name}us-e1-subnet-10-50-10"
  project  = "${data.terraform_remote_state.iam.netsec_host_project_id}"
  region   = "us-east1"
}
