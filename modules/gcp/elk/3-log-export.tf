resource "random_id" "suffix" {
  byte_length = 1
}

resource "google_logging_project_sink" "vpc_flows" {
  name                   = "${var.vpc_flow_log_sink_name}"
  destination            = "${var.vpc_flow_log_destination}"
  filter                 = "${var.vpc_flow_log_filter}"
  unique_writer_identity = true
}

resource "google_project_iam_binding" "log_writer" {
  role    = "roles/pubsub.publisher"
  members = ["${google_logging_project_sink.vpc_flows.writer_identity}"]
}
