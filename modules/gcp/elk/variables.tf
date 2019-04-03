variable "name" {
  description = "prefix to be appended to some resources"
  default     = "elk-stack"
}

variable "project" {
  description = "Project where the elk stack instance will be created"
}

variable "network_project" {
  description = "Project where the elk stack subnetwork will be created"
}

variable "machine_type" {
  default = "n1-standard-4"
}

variable "zone" {
  default = "europe-west1-c"
}

variable "list_of_tags" {
  type    = "list"
}

variable "image" {
  description = "OS image"
  default = "debian-cloud/debian-9"
}

variable "disk_type" {
  description = "Disk type - [pd-standard pd-ssd]"
  default = "pd-ssd"
}

variable "disk_size" {
  description = "Disk size"
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

variable "vpc_flow_log_sink_name" {
  description = "VPC flow log sink name"
}

variable "vpc_flow_log_destination" {
  description = "VPC flow log destiname url"
}

variable "vpc_flow_log_filter" {
  description = "VPC flow log filter expression"
}
