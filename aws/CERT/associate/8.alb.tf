resource "aws_lb" "alb" {
  name = "${var.name}alb"
  internal = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb_sg.id}"]
  subnets = [
    "${aws_subnet.subnet_1_public.id}",
    "${aws_subnet.subnet_2_public.id}"
  ]

  enable_deletion_protection = false
/*
  access_logs {
    bucket  = "${aws_s3_bucket.lb_logs.bucket}"
    prefix  = "test-lb"
    enabled = true
  }
*/

  tags {
    Name = "${var.name}alb"
    Environment = "production"
  }
}
