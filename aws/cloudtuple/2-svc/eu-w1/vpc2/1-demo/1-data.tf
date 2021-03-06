# REMOTE STATES
#==============================
# eu-west1 Regional shared stuff
data "terraform_remote_state" "w1_shared" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/eu-w1/shared"
  }
}

# eu-west1 vpc remote state files
data "terraform_remote_state" "w1_vpc2" {
  backend = "gcs"

  config = {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc2"
  }
}

# Existing zones created on aws console
#==============================
data "aws_route53_zone" "cloudtuples_public" {
  name         = "cloudtuples.com."
  private_zone = false
}

data "aws_route53_zone" "cloudtuples_private" {
  name         = "${var.domain_name}."
  vpc_id       = data.terraform_remote_state.w1_vpc2.outputs.vpc2
  private_zone = true
}
