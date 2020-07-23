
output "spoke1" {
  value = {
    sa = google_service_account.spoke1
  }
  sensitive = "true"
}
