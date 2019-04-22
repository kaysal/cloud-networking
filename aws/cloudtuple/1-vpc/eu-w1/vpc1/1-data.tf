# REMOTE STATES
#==============================
# eu-west1 Regional shared stuff
data "terraform_remote_state" "w1_shared" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/eu-w1/shared"
  }
}

# eu-west1 vpc2 remote state files
data "terraform_remote_state" "w1_vpc2" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/eu-w1/vpc2"
  }
}

# us-east1 vpc1 remote state files
data "terraform_remote_state" "e1_vpc1" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/us-e1/vpc1"
  }
}

# gcp vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/0-main/0-vpc"
  }
}

# gcp untrust vpc remote state files
data "terraform_remote_state" "untrust" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/1-pan/0-vpc"
  }
}

# gcp vpcuser16 remote state files
data "terraform_remote_state" "vpcuser16" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/vpcuser16/private-dns/0-vpc"
  }
}

# Existing zones created on aws console
#==============================
data "aws_route53_zone" "cloudtuples_public" {
  name         = "cloudtuples.com."
  private_zone = false
}

# ami definition
#==============================
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  owners = ["amazon"]
}

data "aws_ami" "ami_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"

    #values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
