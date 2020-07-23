
data "template_file" "unbound_init" {
  template = file("./scripts/unbound.sh.tpl")
  vars = {
    DNS_NAME1    = "server.onprem.lab"
    A_RECORD1    = var.onprem.ip.server
    SPOKE1_DNS   = "spoke1.lab."
    SPOKE2_DNS   = "spoke2.lab."
    SPOKE1_FWD   = var.hub.trust1.ip.ns
    SPOKE2_FWD   = var.hub.trust2.ip.ns
    EGRESS_PROXY = "35.199.192.0/19"
  }
}

resource "aws_instance" "unbound" {
  instance_type          = "t2.medium"
  availability_zone      = "${var.onprem.location}a"
  ami                    = data.aws_ami.debian.id
  key_name               = aws_key_pair.kp.id
  vpc_security_group_ids = [aws_security_group.prv_sg.id]
  subnet_id              = aws_subnet.prv_subnet_a.id
  private_ip             = var.onprem.ip.unbound
  user_data              = data.template_file.unbound_init.rendered

  tags = {
    Name = "${local.prefix}unbound"
    ldap = "salawu"
  }
}
