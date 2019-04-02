resource "google_pubsub_topic" "logstash_input_dev" {
  name = "${var.google_pubsub_topic}"
}
