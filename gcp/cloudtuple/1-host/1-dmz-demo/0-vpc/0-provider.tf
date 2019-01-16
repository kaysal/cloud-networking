
provider "google" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
}

provider "google-beta" {
  project    = "${data.terraform_remote_state.host.host_project_id}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/1-dmz-demo/0-vpc"
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

data "terraform_remote_state" "prod" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/5-prod"
  }
}

data "terraform_remote_state" "dev" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/6-dev"
  }
}
