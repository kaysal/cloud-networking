
provider "google" {
  project = var.project_id_hub
}

provider "google-beta" {
  project = var.project_id_hub
}

# org admin remote state files

data "terraform_remote_state" "host" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# data

data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  name    = "public-host-cloudtuple"
}
