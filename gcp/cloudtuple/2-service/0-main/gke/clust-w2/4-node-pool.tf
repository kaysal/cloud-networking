resource "google_container_node_pool" "node_pool_w2" {
  name       = "${var.name}node-pool-w2"
  cluster    = "${google_container_cluster.clust_w2.name}"
  region = "europe-west2"
  node_count = 1

  node_config {
    tags = ["nat-europe-west2","gke"]
    machine_type = "n1-standard-1"
    #image_type = "Ubuntu"
    #service_account = "${data.terraform_remote_state.gke.node_gke_service_project_service_account_email}"

    oauth_scopes = [
       "https://www.googleapis.com/auth/cloud-platform",
     ]

     metadata {
       ssh-keys = "user:${file("${var.public_key_path}")}"
     }
  }
}
