# folder ids
output "apple_folder_id" {
  value = google_folder.apple_folder.id
}

# project ids
output "apple_service_project_id" {
  value = google_project.apple_service_project.id
}

# project number
output "apple_service_project_number" {
  value = google_project.apple_service_project.number
}

# instances service accounts
output "vm_apple_service_project_service_account_email" {
  value = google_service_account.vm_apple_service_project.email
}

