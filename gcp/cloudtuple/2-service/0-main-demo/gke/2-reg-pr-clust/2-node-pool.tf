resource "google_container_node_pool" "node_pool" {
  name       = "${var.name}node-pool"
  cluster    = "${google_container_cluster.reg_pr_clust.name}"
  region = "europe-west1"
  node_count = 1

  node_config {
    tags = ["nat-europe-west1","gke-node"]
    machine_type = "g1-small"
    #service_account = "${data.terraform_remote_state.gke.node_gke_service_project_service_account_email}"

    oauth_scopes = [
       "https://www.googleapis.com/auth/compute",
       "https://www.googleapis.com/auth/devstorage.read_only",
       "https://www.googleapis.com/auth/logging.write",
       "https://www.googleapis.com/auth/monitoring",
       "https://www.googleapis.com/auth/cloud-platform",
     ]

     metadata {
       ssh-keys = "user:${file("${var.public_key_path}")}"
     }
  }
}
