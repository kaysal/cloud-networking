module "gke" {
  source     = "github.com/kaysal/modules//gcp/gke"
  project_id = "${data.terraform_remote_state.gke.gke_service_project_id}"

  # cluster
  name                           = "${var.name}clust-w2"
  enable_private_endpoint        = false
  enable_private_nodes           = true
  master_ipv4_cidr_block         = "172.16.0.48/28"
  min_master_version             = "1.11.8-gke.6"
  network                        = "${data.google_compute_network.vpc.self_link}"
  subnetwork                     = "${data.terraform_remote_state.vpc.gke_eu_w2_10_0_8}"
  pods_range_name                = "pod-range"
  services_range_name            = "svc-range"
  location                       = "europe-west2"
  default_max_pods_per_node      = 16
  remove_default_node_pool       = true
  logging_service                = "logging.googleapis.com/kubernetes"
  monitoring_service             = "monitoring.googleapis.com/kubernetes"
  enable_binary_authorization    = false
  network_policy_enabled         = true
  network_policy_config_disabled = true
  kubernetes_dashboard_disabled  = false
  istio_config_disabled          = true

  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = "0.0.0.0/0"
          display_name = "all-external"
        },
      ]
    },
  ]

  cluster_labels = {
    component = "gke"
  }

  # node
  node_count      = 1
  machine_type    = "n1-standard-2"
  service_account = "${data.terraform_remote_state.gke.vm_gke_service_project_service_account_email}"
  network_tags    = ["gke", "mig", "mig-nlb"]
  node_metadata   = "EXPOSE"

  node_labels = {
    component = "gke"
  }

  oauth_scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
  ]
}
