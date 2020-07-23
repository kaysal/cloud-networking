
output "onprem" {
  value = {
    vpc       = aws_vpc.vpc
    pub_rtb_a = aws_route_table.pub_rtb_a
    pub_rtb_b = aws_route_table.pub_rtb_b
    prv_rtb_a = aws_route_table.prv_rtb_a
    prv_rtb_b = aws_route_table.prv_rtb_b
  }
  sensitive = "true"
}
