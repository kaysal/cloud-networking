resource "google_container_cluster" "hello_cluster" {
  name = "${var.name}hello-cluster"
  private_cluster = false
  zone = "europe-west1-b"
  network       = "${google_compute_network.vpc.self_link}"
  subnetwork = "${google_compute_subnetwork.subnet_10_0_4.self_link}"

  ip_allocation_policy {
    cluster_secondary_range_name = "${var.name}pod-range"
    services_secondary_range_name = "${var.name}svc-range"
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
