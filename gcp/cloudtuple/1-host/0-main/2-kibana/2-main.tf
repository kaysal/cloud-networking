resource "random_id" "suffix" {
  byte_length = 1
}

module "elk_stack" {
  source = "github.com/kaysal/modules.git//gcp/elk"
  project                  = "${data.terraform_remote_state.host.host_project_id}"
  network_project          = "${data.terraform_remote_state.host.host_project_id}"
  name                     = "elk-stack"
  machine_type             = "n1-standard-4"
  zone                     = "europe-west1-c"
  list_of_tags             = ["elk"]
  image                    = "debian-cloud/debian-9"
  disk_type                = "pd-ssd"
  disk_size                = "100"
  network                  = "${data.terraform_remote_state.vpc.vpc}"
  subnetwork               = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"
  google_pubsub_topic      = "logstash-input-dev"
  vpc_flow_log_sink_name   = "vpc-flows-${random_id.suffix.hex}"
  vpc_flow_log_destination = "pubsub.googleapis.com/projects/${data.terraform_remote_state.host.host_project_id}/topics/${module.elk_stack.pubsub_topic}"
  vpc_flow_log_filter      = "resource.type=\"gce_subnetwork\" logName=\"projects/${data.terraform_remote_state.host.host_project_id}/logs/compute.googleapis.com%2Fvpc_flows\""
}

resource "google_dns_record_set" "elk_public" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "elk.host.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${module.elk_stack.elk_nat_ip}"]
}
