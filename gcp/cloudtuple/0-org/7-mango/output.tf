# folder ids
output "mango_folder_id" {
  value = "${google_folder.mango_folder.id}"
}

# project ids
output "mango_service_project_id" {
  value = "${google_project.mango_service_project.id}"
}

# project number
output "mango_service_project_number" {
  value = "${google_project.mango_service_project.number}"
}

# terraform service accounts
output "tf_mango_service_project_service_account_email" {
  value = "${google_service_account.tf_mango_service_project.email}"
}

# instances service accounts
output "vm_mango_service_project_service_account_email" {
  value = "${google_service_account.vm_mango_service_project.email}"
}
