resource "google_logging_project_sink" "vpc_flows" {
    name = "vpc-flows"
    destination = "pubsub.googleapis.com/projects/${data.terraform_remote_state.host.host_project_id}/topics/${google_pubsub_topic.logstash_input_dev.name}"
    filter = "resource.type=\"gce_subnetwork\" logName=\"projects/host-project-39/logs/compute.googleapis.com%2Fvpc_flows\""
    unique_writer_identity = true
}

resource "google_project_iam_binding" "log_writer" {
    role = "roles/pubsub.publisher"
    members = ["${google_logging_project_sink.vpc_flows.writer_identity}"]
}
