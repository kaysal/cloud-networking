# folder ids
output "gke_folder_id" {
  value = google_folder.gke_folder.id
}

# project ids
output "gke_service_project_id" {
  value = google_project.gke_service_project.id
}

# project number
output "gke_service_project_number" {
  value = google_project.gke_service_project.number
}

# service account email
output "vm_gke_service_project_service_account_email" {
  value = google_service_account.vm_gke_service_project.email
}

