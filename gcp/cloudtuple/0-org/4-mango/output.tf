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
