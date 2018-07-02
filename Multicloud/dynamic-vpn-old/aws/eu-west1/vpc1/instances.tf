# Create the instances

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "vpc1_eu_w1a_ubuntu" {
  instance_type          = "t2.small"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name_eu_west1}"
  vpc_security_group_ids = ["${aws_security_group.vpc1_sec_grp.id}"]
  subnet_id              = "${aws_subnet.vpc1_eu_w1a_subnet.id}"
  user_data              = "${base64encode(file("./scripts/ubuntu-script.sh"))}"

  tags {
    Name = "${var.name}-vpc1-eu-w1a-ubuntu"
  }
}

resource "aws_instance" "vpc1_eu_w1b_ubuntu" {
  instance_type          = "t2.small"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name_eu_west1}"
  vpc_security_group_ids = ["${aws_security_group.vpc1_sec_grp.id}"]
  subnet_id              = "${aws_subnet.vpc1_eu_w1a_subnet.id}"
  user_data              = "${base64encode(file("./scripts/ubuntu-script.sh"))}"

  tags {
    Name = "${var.name}-vpc1-eu-w1b-ubuntu"
  }
}

resource "aws_instance" "vpc1_eu_w1b_windows" {
  instance_type          = "t2.small"
  ami                    = "ami-894c7bf0"
  key_name               = "${var.key_name_eu_west1}"
  vpc_security_group_ids = ["${aws_security_group.vpc1_sec_grp.id}"]
  subnet_id              = "${aws_subnet.vpc1_eu_w1b_subnet.id}"

  tags {
    Name = "${var.name}-vpc1-eu-w1b-windows"
  }
}
