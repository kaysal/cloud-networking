locals {
  prefix       = "cloutuple-"
}

# Cloudtuple Domain Verification Website
#-------------------------------------------

# vpc

locals {
  subnet_name = "cloudtuple"
}

module "vpc" {
  source       = "../../../../../tf_modules/gcp/vpc"
  project_id   = data.terraform_remote_state.host.outputs.host_project_id
  network_name = "cloudtuple"
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name           = local.subnet_name
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "europe-west2"
      subnet_private_access = false
      subnet_flow_logs      = false
    },
  ]

  secondary_ranges = {
    "${local.subnet_name}" = []
  }
}

# firewall rules

resource "google_compute_firewall" "allow_ssh_http" {
  provider = "google-beta"
  name     = "${local.prefix}allow-ssh-http"
  network  = "${module.vpc.network_self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["cloudtuple"]
}

# web server

locals {
  vm_init = templatefile("${path.module}/scripts/startup.sh.tpl", {
    VAR = "value"
  })
}

module "vm_cloudtuple" {
  #source          = "github.com/kaysal/modules.git//gcp/gce-public"
  source          = "../../../../../tf_modules/gcp/gce-public"
  name            = "${local.prefix}vm"
  project         = data.terraform_remote_state.host.outputs.host_project_id
  subnetwork      = "${module.vpc.subnets_self_links[0]}"
  zone            = "europe-west2-b"
  tags            = ["cloudtuple"]

  metadata_startup_script = local.vm_init
  service_account_email   = data.terraform_remote_state.host.outputs.vm_host_project_service_account_email
}
