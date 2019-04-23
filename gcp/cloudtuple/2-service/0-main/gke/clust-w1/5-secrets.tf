# Service Account
#----------------------------------
resource "google_service_account" "php_app" {
  account_id   = "php-app"
  display_name = "PHP app pod svc account"
}

resource "google_service_account_key" "php_key" {
  service_account_id = "${google_service_account.php_app.name}"
}

resource "google_project_iam_binding" "php_app_owner_role" {
  project = "${data.terraform_remote_state.gke.gke_service_project_id}"
  role    = "roles/owner"

  members = [
    "serviceAccount:${google_service_account.php_app.email}",
  ]
}
/*
# Kubernetes secret
#----------------------------------
resource "kubernetes_secret" "phpkey" {
  metadata = {
    name = "phpkey"
  }
  data {
    key.json = "${base64decode(google_service_account_key.php_key.private_key)}"
  }
}*/
