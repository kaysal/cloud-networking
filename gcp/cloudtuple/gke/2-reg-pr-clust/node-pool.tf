resource "google_container_node_pool" "reg_node_pool" {
  name       = "${var.name}reg-node-pool"
  cluster    = "${google_container_cluster.reg_pr_clust.name}"
  region = "europe-west1"
  node_count = 1

  node_config {
    tags = ["vm"]
    machine_type = "g1-small"
    service_account = "${data.terraform_remote_state.gke.node_gke_service_project_service_account_email}"
  }
}
