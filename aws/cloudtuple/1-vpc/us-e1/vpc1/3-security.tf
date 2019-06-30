# bastion sg
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
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.bastion_pub_sg.id
}

resource "aws_security_group_rule" "bastion_traceroute_ingress" {
  type              = "ingress"
  from_port         = 33434
  to_port           = 33534
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
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

# alb sg
#--------------------------
resource "aws_security_group" "alb_pub_sg" {
  name   = "${var.name}alb-pub-sg"
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name  = "${var.name}alb-pub-sg"
    Scope = "public"
  }
}

# http(s) ingress

resource "aws_security_group_rule" "alb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.alb_pub_sg.id
}

resource "aws_security_group_rule" "alb_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.alb_pub_sg.id
}

# egress

resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.alb_pub_sg.id
}

# nlb sg
#--------------------------
resource "aws_security_group" "nlb_prv_sg" {
  name   = "${var.name}nlb-prv-sg"
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name  = "${var.name}nlb-prv-sg"
    Scope = "private"
  }
}

# http(s) ingress

resource "aws_security_group_rule" "nlb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.nlb_prv_sg.id
}

# egress

resource "aws_security_group_rule" "nlb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.nlb_prv_sg.id
}

# launch template sg
#--------------------------
resource "aws_security_group" "launch_prv_sg" {
  name   = "${var.name}launch-prv-sg"
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name  = "${var.name}launch-prv-sg"
    Scope = "private"
  }
}

# http ingress (alb, nlb & all)

resource "aws_security_group_rule" "launch_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.launch_prv_sg.id
}

# bastion ingress

resource "aws_security_group_rule" "launch_bastion_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.bastion_pub_sg.id
  security_group_id        = aws_security_group.launch_prv_sg.id
}

# icmp & traceroute

resource "aws_security_group_rule" "launch_icmp_ingress" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.launch_prv_sg.id
}

resource "aws_security_group_rule" "launch_traceroute_ingress" {
  type              = "ingress"
  from_port         = 33434
  to_port           = 33534
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.launch_prv_sg.id
}

# egress

resource "aws_security_group_rule" "launch_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.launch_prv_sg.id
}

# ec2 sg
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
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ec2_prv_sg.id
}

resource "aws_security_group_rule" "ec2_prv_traceroute_ingress" {
  type              = "ingress"
  from_port         = 33434
  to_port           = 33534
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ec2_prv_sg.id
}

# bastion ingress

resource "aws_security_group_rule" "ec2_prv_bastion_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.bastion_pub_sg.id
  security_group_id        = aws_security_group.ec2_prv_sg.id
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

# endpoint group
#--------------------------
resource "aws_security_group" "endpoint_sg" {
  name   = "${var.name}endpoint-sg"
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name  = "${var.name}endpoint-sg"
    Scope = "private"
  }
}

# http ingress

resource "aws_security_group_rule" "endpoint_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.endpoint_sg.id
}

# outputs
#--------------------------
output "bastion_pub_sg" {
  value = aws_security_group.bastion_pub_sg.id
}

output "alb_pub_sg" {
  value = aws_security_group.alb_pub_sg.id
}

output "nlb_prv_sg" {
  value = aws_security_group.nlb_prv_sg.id
}

output "launch_prv_sg" {
  value = aws_security_group.launch_prv_sg.id
}

output "ec2_prv_sg" {
  value = aws_security_group.ec2_prv_sg.id
}

output "endpoint_sg" {
  value = aws_security_group.endpoint_sg.id
}

