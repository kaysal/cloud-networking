resource "google_container_cluster" "clust_w1" {
  provider = "google-beta"
  name = "${var.name}clust-w1"
  region = "europe-west1"
  network = "${data.terraform_remote_state.vpc.vpc}"
  subnetwork = "${data.terraform_remote_state.vpc.gke_eu_w1_10_0_4}"

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes = true
    master_ipv4_cidr_block = "172.16.0.32/28"
  }

  master_authorized_networks_config {
    cidr_blocks = [
      {
        cidr_block = "${var.onprem_ip_range}",
        display_name = "on-prem"
      },
    ]
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "pod-range"
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
    enabled = true
  }

  lifecycle {
    ignore_changes = ["node_pool"]
  }

  node_pool {
    name = "default-pool"
  }
}
