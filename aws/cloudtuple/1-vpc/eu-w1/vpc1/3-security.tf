# BASTION SG
#--------------------------
resource "aws_security_group" "bastion_pub_sg" {
  name   = "${var.name}bastion-pub-sg"
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name  = "${var.name}bastion-pub-sg"
    Scope = "public"
  }
}

# ssh ingress

resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.bastion_pub_sg.id
}

# icmp & traceroute ingress

resource "aws_security_group_rule" "bastion_icmp_ingress" {
  type      = "ingress"
  from_port = 8
  to_port   = 0
  protocol  = "icmp"

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]

  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.bastion_pub_sg.id
}

resource "aws_security_group_rule" "bastion_traceroute_ingress" {
  type      = "ingress"
  from_port = 33434
  to_port   = 33534
  protocol  = "udp"

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]

  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.bastion_pub_sg.id
}

# egress

resource "aws_security_group_rule" "bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.bastion_pub_sg.id
}

# VYOS ROUTER SG
#--------------------------
resource "aws_security_group" "vyos_pub_sg" {
  name   = "${var.name}vyos-pub-sg"
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name  = "${var.name}vyos-pub-sg"
    Scope = "public"
  }
}

# ssh ingress

resource "aws_security_group_rule" "vyos_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.vyos_pub_sg.id
}

# bastion ingress

resource "aws_security_group_rule" "bastion_ingress" {
  type                     = "ingress"
  from_port                = "0"
  to_port                  = "0"
  protocol                 = "-1"
  source_security_group_id = aws_security_group.bastion_pub_sg.id
  security_group_id        = aws_security_group.vyos_pub_sg.id
}

# ike & ipsec ingress

resource "aws_security_group_rule" "vyos_udp_500_ingress" {
  type              = "ingress"
  from_port         = 500
  to_port           = 500
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.vyos_pub_sg.id
}

resource "aws_security_group_rule" "vyos_udp_4500_ingress" {
  type              = "ingress"
  from_port         = 4500
  to_port           = 4500
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.vyos_pub_sg.id
}

# vyos sg ingress

resource "aws_security_group_rule" "vyos_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.vyos_pub_sg.id
  security_group_id        = aws_security_group.vyos_pub_sg.id
}

# ec2 ingress

resource "aws_security_group_rule" "vpc_ec2_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.ec2_prv_sg.id
  security_group_id        = aws_security_group.vyos_pub_sg.id
}

# egress

resource "aws_security_group_rule" "vyos_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.vyos_pub_sg.id
}

# EC2 INSTANCES SG
#--------------------------
resource "aws_security_group" "ec2_prv_sg" {
  name   = "${var.name}ec2-prv-sg"
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name  = "${var.name}ec2-prv-sg"
    Scope = "private"
  }
}

# icmp & traceroute ingress

resource "aws_security_group_rule" "ec2_prv_icmp_ingress" {
  type      = "ingress"
  from_port = 8
  to_port   = 0
  protocol  = "icmp"

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]

  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ec2_prv_sg.id
}

resource "aws_security_group_rule" "ec2_prv_traceroute_ingress" {
  type      = "ingress"
  from_port = 33434
  to_port   = 33534
  protocol  = "udp"

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]

  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ec2_prv_sg.id
}

# bastion ingress

resource "aws_security_group_rule" "ec2_prv_bastion_ingress" {
  type                     = "ingress"
  from_port                = "0"
  to_port                  = "0"
  protocol                 = "-1"
  source_security_group_id = aws_security_group.bastion_pub_sg.id
  security_group_id        = aws_security_group.ec2_prv_sg.id
}

# dns ingres (for bind server)

resource "aws_security_group_rule" "ec2_prv_tcp_dns_ingress" {
  type      = "ingress"
  from_port = 53
  to_port   = 53
  protocol  = "tcp"

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]

  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ec2_prv_sg.id
}

resource "aws_security_group_rule" "ec2_prv_udp_dns_ingress" {
  type      = "ingress"
  from_port = 53
  to_port   = 53
  protocol  = "udp"

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]

  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ec2_prv_sg.id
}

# egress

resource "aws_security_group_rule" "ec2_prv_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ec2_prv_sg.id
}

# OUTPUTS
#--------------------------
output "bastion_pub_sg" {
  value = aws_security_group.bastion_pub_sg.id
}

output "vyos_pub_sg" {
  value = aws_security_group.bastion_pub_sg.id
}

output "ec2_prv_sg" {
  value = aws_security_group.ec2_prv_sg.id
}

