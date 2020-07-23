
# provider

provider "aws" {
  region = "eu-west-1"
}

provider "random" {}

# locals

locals {
  prefix = "${var.global.prefix}${var.onprem.prefix}"
}

# ami

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-10-amd64-*"]
  }

  owners = ["136693071363"]
}
