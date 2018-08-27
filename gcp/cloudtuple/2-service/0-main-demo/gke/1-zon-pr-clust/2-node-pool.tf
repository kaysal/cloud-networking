resource "google_container_node_pool" "zon_node_pool" {
  name       = "${var.name}node-pool"
  cluster    = "${google_container_cluster.zon_pr_clust.name}"
  zone = "europe-west2-a"
  node_count = 1

  node_config {
    tags = ["nat-europe-west2","gke-node"]
    machine_type = "g1-small"
    service_account = "${data.terraform_remote_state.gke.node_gke_service_project_service_account_email}"
  }
}
