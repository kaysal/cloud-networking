
# public
#---------------------------------

# sg

resource "aws_security_group" "pub_sg" {
  name   = "${local.prefix}pub-sg"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${local.prefix}pub-sg"
    Scope = "public"
    ldap  = "salawu"
  }
}

# rules

resource "aws_security_group_rule" "pub_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pub_sg.id
}

resource "aws_security_group_rule" "pub_rfc1918_cgn" {
  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]

  security_group_id = aws_security_group.pub_sg.id
}

resource "aws_security_group_rule" "pub_bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pub_sg.id
}

# private
#---------------------------------

# sg

resource "aws_security_group" "prv_sg" {
  name   = "${local.prefix}prv-sg"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${local.prefix}prv-sg"
    Scope = "private"
    ldap  = "salawu"
  }
}

# rules

resource "aws_security_group_rule" "prv_ssh_ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pub_sg.id
  security_group_id        = aws_security_group.prv_sg.id
}

resource "aws_security_group_rule" "prv_rfc1918_cgn" {
  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]

  security_group_id = aws_security_group.prv_sg.id
}

resource "aws_security_group_rule" "prv_bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.prv_sg.id
}
