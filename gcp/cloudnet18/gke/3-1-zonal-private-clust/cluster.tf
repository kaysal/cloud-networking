resource "google_container_cluster" "private_zonal_clust" {
  name = "${var.name}private-zonal-clust"
  private_cluster = true
  zone = "europe-west1-b"
  master_ipv4_cidr_block = "172.16.0.32/28"
  subnetwork = "${google_compute_subnetwork.k8s_subnet_10_0_4.self_link}"

  additional_zones = [
    "europe-west1-c",
    "europe-west1-d",
  ]

  ip_allocation_policy {
    cluster_secondary_range_name = "${var.name}pod-range"
    services_secondary_range_name = "${var.name}svc-range"
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
