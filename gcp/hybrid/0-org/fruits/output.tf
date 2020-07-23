
output "fruits" {
  value = {
    apple = {
      folder          = google_folder.apple
      project         = google_project.apple_project
      service_account = google_service_account.vm_apple_project
    }
    orange = {
      folder          = google_folder.orange
      project         = google_project.orange_project
      service_account = google_service_account.vm_orange_project
    }
    mango = {
      folder          = google_folder.mango
      project         = google_project.mango_project
      service_account = google_service_account.vm_mango_project
    }
  }
  sensitive = "true"
}
