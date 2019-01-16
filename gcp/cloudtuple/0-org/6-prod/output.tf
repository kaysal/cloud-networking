# folder ids
output "prod_folder_id" {
  value = "${google_folder.prod_folder.id}"
}

# project ids
output "prod_service_project_id" {
  value = "${google_project.prod_service_project.id}"
}

# project number
output "prod_service_project_number" {
  value = "${google_project.prod_service_project.number}"
}

# terraform service accounts
output "tf_prod_service_project_service_account_email" {
  value = "${google_service_account.tf_prod_service_project.email}"
}

# instances service accounts
output "vm_prod_service_project_service_account_email" {
  value = "${google_service_account.vm_prod_service_project.email}"
}
