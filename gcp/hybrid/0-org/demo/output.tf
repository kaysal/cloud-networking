
output "demo" {
  value = {
    dev = {
      folder          = google_folder.dev
      project         = google_project.dev_project
      service_account = google_service_account.vm_dev_project
    }
    prod = {
      folder          = google_folder.prod
      project         = google_project.prod_project
      service_account = google_service_account.vm_prod_project
    }
    stage = {
      folder          = google_folder.stage
      project         = google_project.stage_project
      service_account = google_service_account.vm_stage_project
    }
  }
  sensitive = "true"
}
