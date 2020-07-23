
# key pair

resource "aws_key_pair" "kp" {
  key_name   = "${local.prefix}kp"
  public_key = file(var.public_key_path)

  tags = {
    ldap = "salawu"
  }
}
