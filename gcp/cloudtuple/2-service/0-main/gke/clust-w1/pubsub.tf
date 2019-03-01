resource "google_pubsub_topic" "echo" {
  name = "echo-topic"
}

resource "google_pubsub_subscription" "echo-read" {
  name  = "echo-subscription"
  topic = "${google_pubsub_topic.echo.name}"
/*
  ack_deadline_seconds = 20

  push_config {
    push_endpoint = "https://example.com/push"

    attributes {
      x-goog-version = "v1"
    }
  }*/
}
