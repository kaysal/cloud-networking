resource "aws_security_group" "eu_w1_vpc1_sec_grp" {
  name   = "${var.name}eu-w1-vpc1-sec-grp"
  vpc_id = "${aws_vpc.eu_w1_vpc1.id}"

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
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0","${data.external.onprem_ip.result.ip}/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0","${data.external.onprem_ip.result.ip}/32"]
  }

  # udp from local rfc1918 and google dns forwarding range
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
      "10.0.0.0/8",
      "172.16.0.0/12",
      "35.199.192.0/19"
    ]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"

    cidr_blocks = [
      "192.168.0.0/16",
      "10.0.0.0/8",
      "172.16.0.0/12",
      "35.199.192.0/19"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
