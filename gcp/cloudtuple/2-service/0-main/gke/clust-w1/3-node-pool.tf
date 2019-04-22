resource "google_container_node_pool" "node_pool_w1" {
  provider   = "google-beta"
  name       = "${var.name}node-pool-w1"
  cluster    = "${google_container_cluster.clust_w1.name}"
  location   = "europe-west1"
  node_count = 1

  node_config {
    machine_type    = "n1-standard-2"
    service_account = "${data.terraform_remote_state.gke.vm_gke_service_project_service_account_email}"
    tags            = ["nat-europe-west1", "gke"]

    labels {
      engine = "gke"
    }

    workload_metadata_config {
      node_metadata = "EXPOSE"
    }

    metadata {
      ssh-keys = "user:${file("${var.public_key_path}")}"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
