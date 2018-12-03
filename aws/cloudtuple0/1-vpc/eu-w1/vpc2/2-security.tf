# Appliance Public SG
#==============================
resource "aws_security_group" "appliance_pub_sg" {
  name   = "${var.name}appliance-pub-sg"
  vpc_id = "${aws_vpc.vpc2.id}"

  tags {
    Name  = "${var.name}appliance-pub-sg"
    Scope = "public"
  }
}

resource "aws_security_group_rule" "appliance_pub_ssh_ingress" {
  type             = "ingress"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  #cidr_blocks       = ["${data.external.onprem_ip.result.ip}/32"]
  security_group_id = "${aws_security_group.appliance_pub_sg.id}"
}

resource "aws_security_group_rule" "appliance_pub_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.appliance_pub_sg.id}"
}

resource "aws_security_group_rule" "appliance_pub_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.appliance_pub_sg.id}"
}

# Appliance Private SG
#==============================
resource "aws_security_group" "appliance_prv_sg" {
  name   = "${var.name}appliance-prv-sg"
  vpc_id = "${aws_vpc.vpc2.id}"

  tags {
    Name  = "${var.name}appliance-prv-sg"
    Scope = "private"
  }
}

resource "aws_security_group_rule" "appliance_prv_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.ec2_prv_sg.id}"
  security_group_id        = "${aws_security_group.appliance_prv_sg.id}"
}

resource "aws_security_group_rule" "appliance_prv_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.appliance_prv_sg.id}"
}

# EC2 INSTANCES SG
#==============================
resource "aws_security_group" "ec2_prv_sg" {
  name   = "${var.name}ec2-prv-sg"
  vpc_id = "${aws_vpc.vpc2.id}"

  tags {
    Name  = "${var.name}ec2-prv-sg"
    Scope = "private"
  }
}

resource "aws_security_group_rule" "ec2_prv_icmp_ingress" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.ec2_prv_sg.id}"
}

resource "aws_security_group_rule" "ec2_prv_traceroute_ingress" {
  type              = "ingress"
  from_port         = 33434
  to_port           = 33534
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.ec2_prv_sg.id}"
}

resource "aws_security_group_rule" "ec2_prv_appliance_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.appliance_prv_sg.id}"
  security_group_id        = "${aws_security_group.ec2_prv_sg.id}"
}

resource "aws_security_group_rule" "ec2_prv_tcp_dns_ingress" {
  type             = "ingress"
  from_port        = 53
  to_port          = 53
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = "${aws_security_group.ec2_prv_sg.id}"
}

resource "aws_security_group_rule" "ec2_prv_udp_dns_ingress" {
  type             = "ingress"
  from_port        = 53
  to_port          = 53
  protocol         = "udp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = "${aws_security_group.ec2_prv_sg.id}"
}

resource "aws_security_group_rule" "ec2_prv_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.ec2_prv_sg.id}"
}

# OUTPUTS
#==============================
output "appliance_pub_sg" {
  value = "${aws_security_group.appliance_pub_sg.id}"
}

output "appliance_prv_sg" {
  value = "${aws_security_group.appliance_prv_sg.id}"
}

output "ec2_prv_sg" {
  value = "${aws_security_group.ec2_prv_sg.id}"
}
