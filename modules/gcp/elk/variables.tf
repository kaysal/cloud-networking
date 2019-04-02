variable "name" {
  description = "prefix to be appended to some resources"
  default     = ""
}

variable "machine_type" {
  default = "n1-standard-4"
}

variable "zone" {
  default = "europe-west1-c"
}

variable "list_of_tags" {
  type    = "list"
  default = ["elk"]
}

variable "image" {
  default = "debian-cloud/debian-9"
}

variable "type" {
  default = "pd-ssd"
}

variable "size" {
  default = "100"
}

variable "network" {
  description = "The VPC where the elk-stack instance will be created"
  default     = "default"
}

variable "subnetwork" {
  description = "The VPC subnetwork where the elk-stack instance will be created"
  default     = "default"
}

variable "google_pubsub_topic" {
  default = "logstash-input-dev"
}
