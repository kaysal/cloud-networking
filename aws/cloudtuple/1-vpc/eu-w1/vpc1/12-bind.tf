# BIND Name Server ns01
#==============================

locals {
  name_server_ip = "172.16.10.100"
  gcp_remote_ns  = "10.100.10.40;10.150.10.2;10.200.10.2;10.250.10.2"
}

data "template_file" "bind_init" {
  template = file("./scripts/bind.sh.tpl")

  vars = {
    NAME_SERVER                    = "127.0.0.1"
    DOMAIN_NAME                    = "cloudtuples.com"
    DOMAIN_NAME_SEARCH             = "west1.cloudtuples.com"
    LOCAL_FORWARDERS               = "172.16.0.2"
    LOCAL_NAME_SERVER_IP           = local.name_server_ip
    LOCAL_ZONE                     = "west1.cloudtuples.com"
    LOCAL_ZONE_FILE                = "/etc/bind/db.west1.cloudtuples.com"
    LOCAL_ZONE_INV                 = "10.16.172.in-addr.arpa"
    LOCAL_ZONE_INV_FILE            = "/etc/bind/db.west1.cloudtuples.com.inv"
    GCP_DNS_RANGE                  = "35.199.192.0/19"
    GOOGLEAPIS_ZONE                = "googleapis.zone"
    GOOGLEAPIS_ZONE_FILE           = "/etc/bind/db.googleapis.zone"
    REMOTE_ZONE_GCP_HOST_PROJECT   = "host.cloudtuple.com"
    REMOTE_ZONE_GCP_APPLE_PROJECT  = "apple.cloudtuple.com"
    REMOTE_ZONE_GCP_GKE_PROJECT    = "gke.cloudtuple.com"
    REMOTE_ZONE_GCP_ORANGE_PROJECT = "orange.cloudtuple.com"
    REMOTE_ZONE_GCP_MANGO_PROJECT  = "mango.cloudtuple.com"
    REMOTE_NS_GCP_HOST_PROJECT     = local.gcp_remote_ns
    REMOTE_NS_GCP_ORANGE_PROJECT   = local.gcp_remote_ns
    REMOTE_NS_GCP_MANGO_PROJECT    = local.gcp_remote_ns
    REMOTE_ZONE_AWS_EAST1          = "east1.cloudtuples.com"
    REMOTE_NS_AWS_EAST1            = "172.18.11.100;172.18.10.100"
  }
}

resource "aws_instance" "ns01" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1a"
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = data.terraform_remote_state.w1_shared.outputs.kp
  vpc_security_group_ids      = [aws_security_group.ec2_prv_sg.id]
  subnet_id                   = aws_subnet.private_172_16_10.id
  private_ip                  = local.name_server_ip
  associate_public_ip_address = false
  user_data                   = data.template_file.bind_init.rendered

  tags = {
    Name = "${var.name}ns01"
  }
}

output "--- name server ns01---" {
  value = [
    "az:        ${aws_instance.ns01.availability_zone} ",
    "priv ip:   ${aws_instance.ns01.private_ip} ",
    "pub ip:    ${aws_instance.ns01.public_ip} ",
    "priv dns:  ${aws_instance.ns01.private_dns} ",
  ]
}

