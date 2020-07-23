
# jump

resource "aws_instance" "jump" {
  instance_type               = "t2.medium"
  availability_zone           = "${var.onprem.location}a"
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = aws_key_pair.kp.id
  vpc_security_group_ids      = [aws_security_group.pub_sg.id]
  subnet_id                   = aws_subnet.pub_subnet_a.id
  associate_public_ip_address = "true"

  tags = {
    Name = "${local.prefix}jump"
    ldap = "salawu"
  }
}

# customer 1 server

data "template_file" "customer1_init" {
  template = file("./scripts/customer.sh.tpl")
  vars = {
    NAME_SERVER        = var.onprem.ip.unbound1
    DOMAIN_NAME        = "googleapis.com"
    DOMAIN_NAME_SEARCH = "googleapis.com"
  }
}

resource "aws_instance" "customer1" {
  instance_type          = "t2.medium"
  availability_zone      = "${var.onprem.location}a"
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.kp.id
  vpc_security_group_ids = [aws_security_group.prv_sg.id]
  subnet_id              = aws_subnet.prv_subnet_a.id
  private_ip             = var.onprem.ip.customer1
  user_data              = data.template_file.customer1_init.rendered

  tags = {
    Name = "${local.prefix}customer1"
    ldap = "salawu"
  }
}

# customer 2 server

data "template_file" "customer2_init" {
  template = file("./scripts/customer.sh.tpl")
  vars = {
    NAME_SERVER        = var.onprem.ip.unbound2
    DOMAIN_NAME        = "googleapis.com"
    DOMAIN_NAME_SEARCH = "googleapis.com"
  }
}

resource "aws_instance" "customer2" {
  instance_type          = "t2.medium"
  availability_zone      = "${var.onprem.location}b"
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.kp.id
  vpc_security_group_ids = [aws_security_group.prv_sg.id]
  subnet_id              = aws_subnet.prv_subnet_b.id
  private_ip             = var.onprem.ip.customer2
  user_data              = data.template_file.customer2_init.rendered

  tags = {
    Name = "${local.prefix}customer2"
    ldap = "salawu"
  }
}
