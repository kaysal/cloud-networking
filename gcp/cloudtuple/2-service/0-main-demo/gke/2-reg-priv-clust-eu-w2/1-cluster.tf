resource "google_container_cluster" "priv_clust" {
  name = "${var.name}priv-clust"
  private_cluster = true
  region = "europe-west2"
  master_ipv4_cidr_block = "172.16.0.48/28"
  network = "${data.terraform_remote_state.vpc.vpc}"
  subnetwork = "${data.terraform_remote_state.vpc.gke_eu_w2_10_0_8}"

  ip_allocation_policy {
    cluster_secondary_range_name = "pod-range"
    services_secondary_range_name = "svc-range"
  }

  master_authorized_networks_config {
    cidr_blocks = [
      { cidr_block = "${var.onprem_ip_range}", display_name = "on-prem" },
      { cidr_block = "${var.gcloud_console_ip}", display_name = "cloud-console" },
    ]
  }

  addons_config {
    network_policy_config {
      disabled = false
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
