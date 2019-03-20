# REMOTE STATES
#==============================
# eu-west1 vpc1 remote state files
data "terraform_remote_state" "w1_vpc1" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/eu-w1/vpc1"
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

# gcp orange project pan vpc remote state files
data "terraform_remote_state" "orange" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/4-orange/0-vpc"
  }
}

# gcp mango project pan vpc remote state files
data "terraform_remote_state" "mango" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/5-mango/0-vpc"
  }
}

# Existing public zone created on aws console
#==============================
data "aws_route53_zone" "cloudtuples_public" {
  name         = "${var.domain_name}."
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
