resource "google_container_node_pool" "zonal_node_pool" {
  name       = "${var.name}zonal-node-pool"
  cluster    = "${google_container_cluster.private_zonal_clust.name}"
  zone = "europe-west1-b"
  node_count = 3

  node_config {
    machine_type = "f1-micro"
    service_account = "${data.terraform_remote_state.iam.k8s_node_service_project_service_account_email}"
  }
}
