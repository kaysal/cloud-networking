
# unbound - customer 1

data "template_file" "unbound1_init" {
  template = file("./scripts/unbound.sh.tpl")
  vars = {
    DNS_NAME1 = "restricted.googleapis.com"
    A_RECORD1 = "199.36.153.4"
  }
}

resource "aws_instance" "unbound1" {
  instance_type          = "t2.medium"
  availability_zone      = "${var.onprem.location}a"
  ami                    = data.aws_ami.debian.id
  key_name               = aws_key_pair.kp.id
  vpc_security_group_ids = [aws_security_group.prv_sg.id]
  subnet_id              = aws_subnet.prv_subnet_a.id
  private_ip             = var.onprem.ip.unbound1
  user_data              = data.template_file.unbound1_init.rendered

  tags = {
    Name = "${local.prefix}unbound1"
    ldap = "salawu"
  }
}

# unbound - customer 2

data "template_file" "unbound2_init" {
  template = file("./scripts/unbound.sh.tpl")
  vars = {
    DNS_NAME1 = "restricted.googleapis.com"
    A_RECORD1 = "199.36.153.5"
  }
}

resource "aws_instance" "unbound2" {
  instance_type          = "t2.medium"
  availability_zone      = "${var.onprem.location}b"
  ami                    = data.aws_ami.debian.id
  key_name               = aws_key_pair.kp.id
  vpc_security_group_ids = [aws_security_group.prv_sg.id]
  subnet_id              = aws_subnet.prv_subnet_b.id
  private_ip             = var.onprem.ip.unbound2
  user_data              = data.template_file.unbound2_init.rendered

  tags = {
    Name = "${local.prefix}unbound2"
    ldap = "salawu"
  }
}
