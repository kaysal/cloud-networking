resource "aws_lb" "alb" {
  name               = "${var.name}alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${data.terraform_remote_state.w2_vpc1.alb_pub_sg}"]

  subnets = [
    "${data.terraform_remote_state.w2_vpc1.public_172_18_0}",
    "${data.terraform_remote_state.w2_vpc1.public_172_18_1}",
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
    Name        = "${var.name}alb"
    Environment = "production"
  }
}
