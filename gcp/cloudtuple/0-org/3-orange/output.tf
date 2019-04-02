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
