resource "aws_sns_topic" "user_updates" {
  name = "${var.name}user-updates-topic"
}

/*
# email subscription created manually on aws console
resource "aws_sns_topic_subscription" "user_updates__target" {
  topic_arn = "${aws_sns_topic.user_updates.arn}"
  protocol  = "email"
  endpoint  = "${var.sns_target_email}"
}
*/

