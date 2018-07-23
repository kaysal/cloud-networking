variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "cnt-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "peer_project_id" {
  description = "Project ID of peer network"
}

variable "peer_project_vpc_name" {
  description = "Peer network name"
}
