# folder ids
output "orange_folder_id" {
  value = "${google_folder.orange_folder.id}"
}

# project ids
output "orange_project_id" {
  value = "${google_project.orange_project.id}"
}

# project number
output "orange_project_number" {
  value = "${google_project.orange_project.number}"
}

# terraform service accounts
output "tf_orange_project_service_account_email" {
  value = "${google_service_account.tf_orange_project.email}"
}

# instances service accounts
output "vm_orange_project_service_account_email" {
  value = "${google_service_account.vm_orange_project.email}"
}
