# folder ids
output "netsec_folder_id" {
  value = "${google_folder.netsec_folder.id}"
}

# project ids
output "netsec_host_project_id" {
  value = "${google_project.netsec_host_project.id}"
}

# project number
output "netsec_host_project_number" {
  value = "${google_project.netsec_host_project.number}"
}

# terraform service accounts
output "tf_netsec_host_project_service_account_email" {
  value = "${google_service_account.tf_netsec_host_project.email}"
}

# instances service accounts
output "vm_netsec_host_project_service_account_email" {
  value = "${google_service_account.vm_netsec_host_project.email}"
}
