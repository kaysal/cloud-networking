resource "google_service_account" "myaccount" {
  account_id   = "myaccount"
  display_name = "My Service Account"
}

resource "google_service_account_key" "mykey" {
  service_account_id = "${google_service_account.myaccount.name}"
}

resource "kubernetes_secret" "google-application-credentials" {
  metadata = {
    name = "google-application-credentials"
  }
  data {
    credentials.json = "${base64decode(google_service_account_key.mykey.private_key)}"
  }
}
