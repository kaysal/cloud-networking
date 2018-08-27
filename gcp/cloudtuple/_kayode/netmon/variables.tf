variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "name" {
  description = "prefix to be appended to some resources"
  default     = "nm-"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "list_of_regions" {
  type    = "list"
  default = [
    "asia-east1",
    "asia-northeast1",
    "asia-south1",
    "asia-southeast1",
    "australia-southeast1",
    "europe-north1",
    "europe-west1",
    "europe-west2",
    "europe-west3",
    "europe-west4",
    "northamerica-northeast1",
    "southamerica-east1",
    "us-central1",
    "us-east1",
    "us-east4",
    "us-west1",
    "us-west2",
  ]
}

variable "list_of_region_names" {
  type    = "list"
  default = [
    "asia-east1-taiwan",
    "asia-northeast1-tokyo",
    "asia-south1-mumbai",
    "asia-southeast1-singapore",
    "australia-southeast1-sydney",
    "europe-north1-finland",
    "europe-west1-belgium",
    "europe-west2-london",
    "europe-west3-frankfurt",
    "europe-west4-netherlands",
    "northamerica-northeast1-montreal",
    "southamerica-east1-sao-paulo",
    "us-central1-iowa",
    "us-east1-south-carolina",
    "us-east4-n-virginia",
    "us-west1-oregon",
    "us-west2-los-angeles",
  ]
}
