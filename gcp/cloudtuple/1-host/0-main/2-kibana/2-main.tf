module "elk_stack" {
  source              = "github.com/kaysal/cloud-networking/modules/gcp/elk"
  project             = "${data.terraform_remote_state.host.host_project_id}"
  network_project     = "${data.terraform_remote_state.host.host_project_id}"
  machine_type        = ""
  zone                = ""
  list_of_tags        = ""
  image               = ""
  type                = ""
  size                = ""
  network             = ""
  subnetwork          = ""
  google_pubsub_topic = ""
}
