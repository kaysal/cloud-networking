# folder ids
output "host_folder_id" {
  value = "${google_folder.host_folder.id}"
}

# project ids
output "host_project_id" {
  value = "${google_project.host_project.id}"
}

# project number
output "host_project_number" {
  value = "${google_project.host_project.number}"
}

# terraform service accounts
output "tf_host_project_service_account_email" {
  value = "${google_service_account.tf_host_project.email}"
}
