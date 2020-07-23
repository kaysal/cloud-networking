# REMOTE STATES
#==============================
# eu-west1 Regional shared stuff
data "terraform_remote_state" "e1_shared" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/us-e1/shared"
  }
}

# us-east1 vpc remote state files
data "terraform_remote_state" "e1_vpc1" {
  backend = "gcs"

  config = {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/us-e1/vpc1"
    #credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# Existing zones created on aws console
#==============================
data "aws_route53_zone" "cloudtuples_public" {
  name         = "${var.domain_name}."
  private_zone = false
}

data "aws_route53_zone" "cloudtuples_private" {
  name         = "${var.domain_name}."
  vpc_id       = data.terraform_remote_state.e1_vpc1.outputs.vpc1
  private_zone = true
}

data "aws_route53_zone" "googleapis" {
  name         = "googleapis.com"
  vpc_id       = data.terraform_remote_state.e1_vpc1.outputs.vpc1
  private_zone = true
}
