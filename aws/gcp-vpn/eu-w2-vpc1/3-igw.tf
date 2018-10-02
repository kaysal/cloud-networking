# Create vpc internet gateway
resource "aws_internet_gateway" "eu_w2_vpc1_igw" {
  vpc_id = "${aws_vpc.eu_w2_vpc1.id}"

  tags {
    Name = "${var.name}eu-w2-vpc1-igw"
  }
}
