# provider information
provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudnet18/gke/3-2-regional-private-clust"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "iam" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudnet18/gke/1-gcp-org-iam"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
