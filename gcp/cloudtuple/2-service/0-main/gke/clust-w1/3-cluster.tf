resource "google_container_cluster" "clust_w1" {
  provider   = "google-beta"
  name       = "${var.name}clust-w1"
  region     = "europe-west1"
  network    = "${data.terraform_remote_state.vpc.vpc}"
  subnetwork = "${data.terraform_remote_state.vpc.gke_eu_w1_10_0_4}"
  enable_binary_authorization  = true
  logging_service = "logging.googleapis.com"
  initial_node_count = 1
  remove_default_node_pool  = true

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.32/28"
  }

  master_authorized_networks_config {
    cidr_blocks = [
      {cidr_block = "0.0.0.0/0", display_name = "all-external"},
      {cidr_block = "${data.external.onprem_ip.result.ip}/32", display_name = "on-prem"},
    ]
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-range"
    services_secondary_range_name = "svc-range"
  }

  addons_config {
    network_policy_config {
      disabled = false
    }

    kubernetes_dashboard {
      disabled = false
    }

    istio_config {
      disabled = false
      #auth = "AUTH_MUTUAL_TLS"
    }
  }

  network_policy {
    provider = "CALICO"
    enabled  = true
  }
}
