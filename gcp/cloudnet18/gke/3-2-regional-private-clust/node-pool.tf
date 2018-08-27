resource "google_container_node_pool" "regional_node_pool" {
  name       = "${var.name}regional-node-pool"
  cluster    = "${google_container_cluster.private_regional_clust.name}"
  region = "europe-west1"
  node_count = 3

  node_config {
    machine_type = "f1-micro"
    service_account = "${data.terraform_remote_state.iam.k8s_node_service_project_service_account_email}"
  }
}
