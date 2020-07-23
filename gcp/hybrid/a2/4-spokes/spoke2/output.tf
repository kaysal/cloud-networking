
output "spoke2" {
  value = {
    sa = google_service_account.spoke2
  }
  sensitive = "true"
}
