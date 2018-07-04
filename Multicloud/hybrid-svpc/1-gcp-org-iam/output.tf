output "netsec_folder_id" {
  value = "${google_folder.netsec_folder.id}"
}

output "netsec_host_project_id" {
  value = "${google_project.netsec_host_project.id}"
}

output "prod_folder_id" {
  value = "${google_folder.prod_folder.id}"
}

output "prod_service_project_id" {
  value = "${google_project.prod_service_project.id}"
}

output "test_folder_id" {
  value = "${google_folder.test_folder.id}"
}

output "test_service_project_id" {
  value = "${google_project.test_service_project.id}"
}

output "tf_netsec_host_project_service_account_email" {
  value = "${google_service_account.tf_netsec_host_project.email}"
}

output "tf_prod_service_project_service_account_email" {
  value = "${google_service_account.tf_prod_service_project.email}"
}

output "tf_test_service_project_service_account_email" {
  value = "${google_service_account.tf_test_service_project.email}"
}