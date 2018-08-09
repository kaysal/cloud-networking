resource "google_container_node_pool" "custom_node_pool" {
  name       = "${var.name}custom-node-pool"
  cluster    = "${google_container_cluster.hello_cluster.name}"
  zone = "europe-west1-b"
  node_count = 3

  node_config {
    tags = ["vm"]
    machine_type = "n1-standard-1"
    service_account = "${data.terraform_remote_state.iam.k8s_node_service_project_service_account_email}"
    metadata {
      ssh-keys = "user:${file("${var.public_key_path}")}"
    }
  }
}
