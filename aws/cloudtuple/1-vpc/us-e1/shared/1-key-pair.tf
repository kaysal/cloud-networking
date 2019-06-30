# Key Pair
resource "aws_key_pair" "kp" {
  key_name   = "${var.env}kp"
  public_key = file(var.public_key_path)
}

output "kp" {
  value = aws_key_pair.kp.key_name
}

