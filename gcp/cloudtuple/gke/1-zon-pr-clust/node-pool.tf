resource "google_container_node_pool" "zon_node_pool" {
  name       = "${var.name}zon-node-pool"
  cluster    = "${google_container_cluster.pr_zon_clust.name}"
  zone = "europe-west1-b"
  node_count = 3

  node_config {
    machine_type = "g1-small"
    service_account = "${data.terraform_remote_state.gke.node_gke_service_project_service_account_email}"
  }
}
