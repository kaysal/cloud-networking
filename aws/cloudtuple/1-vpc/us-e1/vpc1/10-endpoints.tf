# S3 Endpoint
#==============================
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.vpc1.id}"
  service_name = "com.amazonaws.us-east-1.s3"
}

resource "aws_vpc_endpoint_route_table_association" "private_rtb_a" {
  route_table_id  = "${aws_route_table.private_rtb_a.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
}

resource "aws_vpc_endpoint_route_table_association" "private_rtb_b" {
  route_table_id  = "${aws_route_table.private_rtb_b.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
}

resource "aws_vpc_endpoint_route_table_association" "private_rtb_c" {
  route_table_id  = "${aws_route_table.private_rtb_c.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
}

# EC2 Endpoint
#==============================
resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = "${aws_vpc.vpc1.id}"
  service_name      = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type = "Interface"
  security_group_ids = ["${aws_security_group.ec2_endpoint_sg.id}",]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint_subnet_association" "private_172_18_12" {
  vpc_endpoint_id = "${aws_vpc_endpoint.ec2.id}"
  subnet_id       = "${aws_subnet.private_172_18_12.id}"
}
