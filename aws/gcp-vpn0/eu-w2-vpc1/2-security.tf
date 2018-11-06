resource "aws_security_group" "eu_w2_vpc1_bastion_sg" {
  name   = "${var.name}eu-w2-vpc1-bastion-sg"
  vpc_id = "${aws_vpc.eu_w2_vpc1.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0", "${data.external.onprem_ip.result.ip}/32"]
  }

  # udp from local rfc1918 remote and google dns forwarding range
  ingress {
    from_port = 53
    to_port   = 53
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
      "10.0.0.0/8",
      "172.16.0.0/12",
      "35.199.192.0/19",
    ]
  }

  ingress {
    from_port = 53
    to_port   = 53
    protocol  = "udp"

    cidr_blocks = [
      "192.168.0.0/16",
      "10.0.0.0/8",
      "172.16.0.0/12",
      "35.199.192.0/19",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}eu-w2-vpc1-bastion-sg"
  }
}

resource "aws_security_group" "eu_w2_vpc1_private_sg" {
  name   = "${var.name}eu-w2-vpc1-private-sg"
  vpc_id = "${aws_vpc.eu_w2_vpc1.id}"

  ingress {
    from_port = 8
    to_port   = 0
    protocol  = "icmp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 33434
    to_port   = 33534
    protocol  = "udp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = ["${aws_security_group.eu_w2_vpc1_bastion_sg.id}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.eu_w2_vpc1_bastion_sg.id}"]
  }

  # udp from local rfc1918 remote and google dns forwarding range
  ingress {
    from_port = 53
    to_port   = 53
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
      "10.0.0.0/8",
      "172.16.0.0/12",
      "35.199.192.0/19",
    ]
  }

  ingress {
    from_port = 53
    to_port   = 53
    protocol  = "udp"

    cidr_blocks = [
      "192.168.0.0/16",
      "10.0.0.0/8",
      "172.16.0.0/12",
      "35.199.192.0/19",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}eu-w2-vpc1-private-sg"
  }
}
