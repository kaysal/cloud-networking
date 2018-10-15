# folder ids
output "orange_folder_id" {
  value = "${google_folder.orange_folder.id}"
}

# project ids
output "orange_service_project_id" {
  value = "${google_project.orange_service_project.id}"
}

# project number
output "orange_service_project_number" {
  value = "${google_project.orange_service_project.number}"
}

# terraform service accounts
output "tf_orange_service_project_service_account_email" {
  value = "${google_service_account.tf_orange_service_project.email}"
}

# instances service accounts
output "vm_orange_service_project_service_account_email" {
  value = "${google_service_account.vm_orange_service_project.email}"
}
