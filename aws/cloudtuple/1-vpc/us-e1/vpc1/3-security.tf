# BASTION SG
#==============================
resource "aws_security_group" "bastion_pub_sg" {
  name   = "${var.name}bastion-pub-sg"
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name  = "${var.name}bastion-pub-sg"
    Scope = "public"
  }
}

resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.bastion_pub_sg.id}"
}

resource "aws_security_group_rule" "bastion_icmp_ingress" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.bastion_pub_sg.id}"
}

resource "aws_security_group_rule" "bastion_traceroute_ingress" {
  type              = "ingress"
  from_port         = 33434
  to_port           = 33534
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.bastion_pub_sg.id}"
}

resource "aws_security_group_rule" "bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.bastion_pub_sg.id}"
}

# ALB SG
#==============================
resource "aws_security_group" "alb_pub_sg" {
  name   = "${var.name}alb-pub-sg"
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name  = "${var.name}alb-pub-sg"
    Scope = "public"
  }
}

resource "aws_security_group_rule" "alb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.alb_pub_sg.id}"
}

resource "aws_security_group_rule" "alb_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.alb_pub_sg.id}"
}

resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.alb_pub_sg.id}"
}

# LAUNCH TEMPLATE SG
#==============================
resource "aws_security_group" "launch_prv_sg" {
  name   = "${var.name}launch-prv-sg"
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name  = "${var.name}launch-prv-sg"
    Scope = "private"
  }
}

resource "aws_security_group_rule" "launch_http_ingress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.alb_pub_sg.id}"
  security_group_id        = "${aws_security_group.launch_prv_sg.id}"
}

resource "aws_security_group_rule" "launch_bastion_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.bastion_pub_sg.id}"
  security_group_id        = "${aws_security_group.launch_prv_sg.id}"
}

resource "aws_security_group_rule" "launch_icmp_ingress" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.launch_prv_sg.id}"
}

resource "aws_security_group_rule" "launch_traceroute_ingress" {
  type              = "ingress"
  from_port         = 33434
  to_port           = 33534
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.launch_prv_sg.id}"
}

resource "aws_security_group_rule" "launch_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.launch_prv_sg.id}"
}

# EC2 INSTANCES SG
#==============================
resource "aws_security_group" "ec2_prv_sg" {
  name   = "${var.name}ec2-prv-sg"
  vpc_id = "${aws_vpc.vpc1.id}"

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

resource "aws_security_group_rule" "ec2_prv_bastion_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.bastion_pub_sg.id}"
  security_group_id        = "${aws_security_group.ec2_prv_sg.id}"
}

resource "aws_security_group_rule" "ec2_prv_tcp_dns_ingress" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.ec2_prv_sg.id}"
}

resource "aws_security_group_rule" "ec2_prv_udp_dns_ingress" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
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

# EC2 Endpoint Group
#==============================
resource "aws_security_group" "ec2_endpoint_sg" {
  name   = "${var.name}ec2-endpoint-sg"
  vpc_id = "${aws_vpc.vpc1.id}"

  tags {
    Name  = "${var.name}ec2-endpoint-sg"
    Scope = "private"
  }
}

resource "aws_security_group_rule" "ec2_endpoint_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.ec2_prv_sg.id}"
  security_group_id        = "${aws_security_group.ec2_endpoint_sg.id}"
}

resource "aws_security_group_rule" "ec2_endpoint_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.ec2_endpoint_sg.id}"
}

# OUTPUTS
#==============================
output "bastion_pub_sg" {
  value = "${aws_security_group.bastion_pub_sg.id}"
}

output "alb_pub_sg" {
  value = "${aws_security_group.alb_pub_sg.id}"
}

output "launch_prv_sg" {
  value = "${aws_security_group.launch_prv_sg.id}"
}

output "ec2_prv_sg" {
  value = "${aws_security_group.ec2_prv_sg.id}"
}
