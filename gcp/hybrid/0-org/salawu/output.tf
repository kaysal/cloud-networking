
output "org" {
  value = {
    hub = {
      folder          = google_folder.hub
      project         = google_project.hub_project
      service_account = google_service_account.vm_hub_project
    }
    spoke1 = {
      folder          = google_folder.spokes
      project         = google_project.spoke1_project
      service_account = google_service_account.vm_spoke1_project
    }
    spoke2 = {
      folder          = google_folder.spokes
      project         = google_project.spoke2_project
      service_account = google_service_account.vm_spoke2_project
    }
  }
  sensitive = "true"
}
