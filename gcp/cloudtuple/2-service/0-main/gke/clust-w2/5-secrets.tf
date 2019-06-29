# Service Account
#----------------------------------
resource "google_service_account" "cluster_w2_pods" {
  account_id   = "cluster-w2-pods"
  display_name = "SA account for europe-west2 pods"
}

# service account key used for pods

resource "google_service_account_key" "clust_w2_pod_sa_key" {
  service_account_id = google_service_account.cluster_w2_pods.name
}

# project owner role for pod service account

resource "google_project_iam_member" "cluster_pod_owner" {
  project = data.terraform_remote_state.gke.outputs.gke_service_project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.cluster_w2_pods.email}"
}

# Kubernetes secret
#----------------------------------
resource "kubernetes_secret" "clust_w2_key" {
  metadata {
    name = "clust-w2-key"
  }
  data = {
    "key.json" = "${base64decode(google_service_account_key.clust_w2_pod_sa_key.private_key)}"
  }
}
