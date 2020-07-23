
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

# server

data "template_file" "server_init" {
  template = file("./scripts/server.sh.tpl")
  vars = {
    PREFIX  = var.global.prefix
    ILB1_80 = "${var.hub.untrust.eu1.ip.ilb80}:8080"
    ILB1_81 = "${var.hub.untrust.eu1.ip.ilb81}:8081"
    ILB2_80 = "${var.hub.untrust.eu2.ip.ilb80}:8080"
    ILB2_81 = "${var.hub.untrust.eu2.ip.ilb81}:8081"

    NAME_SERVER        = var.onprem.ip.unbound
    DOMAIN_NAME        = "onprem.lab"
    DOMAIN_NAME_SEARCH = "onprem.lab"

    SPOKE1_PROJECT_ID = var.project_id_spoke1
    SPOKE2_PROJECT_ID = var.project_id_spoke2
  }
}

resource "aws_instance" "server" {
  instance_type          = "t2.medium"
  availability_zone      = "${var.onprem.location}a"
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.kp.id
  vpc_security_group_ids = [aws_security_group.prv_sg.id]
  subnet_id              = aws_subnet.prv_subnet_a.id
  private_ip             = var.onprem.ip.server
  user_data              = data.template_file.server_init.rendered

  tags = {
    Name = "${local.prefix}server"
    ldap = "salawu"
  }
}
