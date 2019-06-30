# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/5-mango/0-vpc"
  }
}

# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

data "terraform_remote_state" "apple" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/2-apple"
  }
}

data "terraform_remote_state" "orange" {
  backend = "gcs"
  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/3-orange"
  }
}

data "terraform_remote_state" "mango" {
  backend = "gcs"
  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/4-mango"
  }
}

# dns data
data "google_dns_managed_zone" "private_mango_cloudtuple" {
  project = data.terraform_remote_state.mango.outputs.mango_project_id
  name    = data.terraform_remote_state.vpc.outputs.private_mango_cloudtuple_name
}

