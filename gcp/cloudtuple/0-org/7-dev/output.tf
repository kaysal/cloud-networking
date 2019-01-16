# folder ids
output "dev_folder_id" {
  value = "${google_folder.dev_folder.id}"
}

# project ids
output "dev_service_project_id" {
  value = "${google_project.dev_service_project.id}"
}

# project number
output "dev_service_project_number" {
  value = "${google_project.dev_service_project.number}"
}

# terraform service accounts
output "tf_dev_service_project_service_account_email" {
  value = "${google_service_account.tf_dev_service_project.email}"
}

# instances service accounts
output "vm_dev_service_project_service_account_email" {
  value = "${google_service_account.vm_dev_service_project.email}"
}
