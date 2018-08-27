# folder ids
output "host_folder_id" {
  value = "${google_folder.host_folder.id}"
}

output "service_folder_id" {
  value = "${google_folder.service_folder.id}"
}

# project ids
output "host_project_id" {
  value = "${google_project.host_project.id}"
}

output "service_project_id" {
  value = "${google_project.service_project.id}"
}

# terraform service accounts
output "tf_host_project_service_account_email" {
  value = "${google_service_account.tf_host_project.email}"
}

output "tf_service_project_service_account_email" {
  value = "${google_service_account.tf_service_project.email}"
}

# instances service accounts
output "instance_host_project_service_account_email" {
  value = "${google_service_account.instance_host_project.email}"
}

output "instance_service_project_service_account_email" {
  value = "${google_service_account.instance_service_project.email}"
}

# k8s service account
output "k8s_node_service_project_service_account_email" {
  value = "${google_service_account.k8s_node_service_project.email}"
}
