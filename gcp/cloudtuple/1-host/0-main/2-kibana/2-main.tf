resource "random_id" "suffix" {
  byte_length = 1
}

module "elk_stack" {
  #source                   = "github.com/kaysal/modules.git//gcp/elk"
  source = "../../../../../../tf_modules/gcp/elk"
  project                  = data.terraform_remote_state.host.outputs.host_project_id
  network_project          = data.terraform_remote_state.host.outputs.host_project_id
  name                     = "elk-stack"
  machine_type             = "n1-standard-4"
  zone                     = "europe-west1-c"
  list_of_tags             = ["elk"]
  image                    = "debian-cloud/debian-9"
  disk_type                = "pd-ssd"
  disk_size                = "100"
  network                  = data.google_compute_network.vpc.self_link
  subnetwork               = data.terraform_remote_state.vpc.outputs.apple_eu_w1_10_100_10
  google_pubsub_topic      = "logstash-input-dev"
  vpc_flow_log_sink_name   = "vpc-flows-${random_id.suffix.hex}"
  vpc_flow_log_destination = "pubsub.googleapis.com/projects/${data.terraform_remote_state.host.outputs.host_project_id}/topics/${module.elk_stack.pubsub_topic}"
  vpc_flow_log_filter      = "resource.type=\"gce_subnetwork\" logName=\"projects/${data.terraform_remote_state.host.outputs.host_project_id}/logs/compute.googleapis.com%2Fvpc_flows\""
}

resource "google_dns_record_set" "elk_public" {
  project      = data.terraform_remote_state.host.outputs.host_project_id
  managed_zone = data.google_dns_managed_zone.public_host_cloudtuple.name
  name         = "elk.host.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  rrdatas = [module.elk_stack.elk_nat_ip]
}
