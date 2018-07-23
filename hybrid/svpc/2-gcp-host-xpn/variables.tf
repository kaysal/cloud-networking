variable "name" {
  description = "prefix to be appended to some resources"
  default     = "cnt-"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "prod_peer_project_id" {
  description = "Project ID of peer network"
}

variable "prod_peer_project_vpc_name" {
  description = "Peer network name"
}
