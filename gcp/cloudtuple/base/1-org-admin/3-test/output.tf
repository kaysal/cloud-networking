# folder ids
output "test_folder_id" {
  value = "${google_folder.test_folder.id}"
}

# project ids
output "test_service_project_id" {
  value = "${google_project.test_service_project.id}"
}

# project number
output "test_service_project_number" {
  value = "${google_project.test_service_project.number}"
}

# terraform service accounts
output "tf_test_service_project_service_account_email" {
  value = "${google_service_account.tf_test_service_project.email}"
}

# instances service accounts
output "vm_test_service_project_service_account_email" {
  value = "${google_service_account.vm_test_service_project.email}"
}
