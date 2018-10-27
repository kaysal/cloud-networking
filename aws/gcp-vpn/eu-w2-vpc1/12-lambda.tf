resource "aws_iam_role" "lambda_role" {
  name = "${var.name}lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.name}lambda-policy"
  role = "${aws_iam_role.lambda_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "sns:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  function_name    = "${var.name}lambda-function"
  filename         = "scripts/lambda_function.py.zip"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "lambda_function.handler"
  source_code_hash = "${base64sha256(file("scripts/lambda_function.py.zip"))}"
  runtime          = "python3.6"

  environment {
    variables = {
      key = "value"
    }
  }
}

resource "aws_cloudwatch_event_rule" "lambda_trigger_rule" {
  name        = "${var.name}lambda-trigger-rule"
  description = "Send annoying 1 minute notifications via sns"
  schedule_expression = "rate(1 minute)"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.test_lambda.function_name}"
  principal      = "events.amazonaws.com"
  source_arn     = "arn:aws:events:eu-west-1:111122223333:rule/RunDaily"
  qualifier      = "${aws_lambda_alias.test_alias.name}"
}

resource "aws_lambda_alias" "test_alias" {
  name             = "testalias"
  description      = "a sample description"
  function_name    = "${aws_lambda_function.test_lambda.function_name}"
  function_version = "$LATEST"
}
