# folder ids
output "netsec_folder_id" {
  value = google_folder.netsec_folder.id
}

# project ids
output "forseti_project_id" {
  value = google_project.forseti_project.id
}

# project number
output "forseti_project_number" {
  value = google_project.forseti_project.number
}

