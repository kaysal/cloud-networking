resource "aws_security_group" "vpc1_sec_grp" {
  name   = "${var.name}-vpc1-sec-grp"
  vpc_id = "${aws_vpc.vpc1_eu_w1.id}"

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
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
