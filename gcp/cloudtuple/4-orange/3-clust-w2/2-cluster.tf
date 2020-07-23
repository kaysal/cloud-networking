locals {
  project         = data.terraform_remote_state.orange.outputs.orange_project_id
  service_account = data.terraform_remote_state.orange.outputs.vm_orange_project_service_account_email
  location        = "europe-west2"
}

# cluster

module "gke" {

  source  = "../../../../../tf_modules/gcp/gke"
  project = local.project

  name       = "${var.name}clust-w2"
  location   = local.location
  network    = data.google_compute_network.vpc.self_link
  subnetwork = data.terraform_remote_state.vpc.outputs.gke_eu_w2_10_0_16

  disable_public_endpoint   = false
  enable_private_nodes      = true
  master_ipv4_cidr_block    = "172.16.0.80/28"
  pods_range_name           = "pod-range"
  services_range_name       = "svc-range"
  default_max_pods_per_node = 16
  min_master_version        = "1.13.7-gke.8"

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  enable_binary_authorization = false
  enable_istio_config         = false

  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = "0.0.0.0/0"
          display_name = "all-ext-testing"
        },
      ]
    },
  ]

  cluster_labels = {
    component = "gke"
  }
}

# node pool

resource "google_container_node_pool" "node_pool" {
  provider = google-beta

  name     = "${var.name}node-pool"
  project  = local.project
  location = local.location
  cluster  = module.gke.name

  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    image_type   = "COS"
    machine_type = "n1-standard-1"

    labels = {
      private = true
    }

    tags = ["gce", "mig"]

    disk_size_gb = "30"
    disk_type    = "pd-standard"
    preemptible  = false

    service_account = local.service_account

    workload_metadata_config {
      node_metadata = "EXPOSE"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}
