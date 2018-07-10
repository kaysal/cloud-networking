# elastic ips for instances
resource "aws_eip" "eu_w1a_vpc1_ubuntu" {
  instance = "${aws_instance.eu_w1a_vpc1_ubuntu.id}"
  vpc      = true
}

resource "aws_eip" "eu_w1b_vpc1_windows" {
  instance = "${aws_instance.eu_w1b_vpc1_windows.id}"
  vpc      = true
}

# ami definition
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

# Create the instances
resource "aws_instance" "eu_w1a_vpc1_ubuntu" {
  instance_type          = "t2.micro"
  availability_zone = "eu-west-1a"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name_eu_west1}"
  vpc_security_group_ids = ["${aws_security_group.eu_w1_vpc1_sec_grp.id}"]
  subnet_id              = "${aws_subnet.eu_w1_vpc1_172_16_10.id}"
  user_data = "${file("./scripts/ubuntu-script.sh")}"
  tags {
    Name = "${var.name}eu-w1a-vpc1-ubuntu"
  }
}

resource "aws_instance" "eu_w1b_vpc1_windows" {
  instance_type          = "t2.micro"
  availability_zone = "eu-west-1b"
  ami                    = "ami-894c7bf0"
  key_name               = "${var.key_name_eu_west1}"
  vpc_security_group_ids = ["${aws_security_group.eu_w1_vpc1_sec_grp.id}"]
  subnet_id              = "${aws_subnet.eu_w1_vpc1_172_16_11.id}"

  tags {
    Name = "${var.name}eu-w1b-vpc1-windows"
  }
}
