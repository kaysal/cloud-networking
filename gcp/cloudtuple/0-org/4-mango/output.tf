# folder ids
output "mango_folder_id" {
  value = "${google_folder.mango_folder.id}"
}

# project ids
output "mango_project_id" {
  value = "${google_project.mango_project.id}"
}

# project number
output "mango_project_number" {
  value = "${google_project.mango_project.number}"
}

# service account email
output "vm_mango_project_service_account_email" {
  value = "${google_service_account.vm_mango_project.email}"
}
