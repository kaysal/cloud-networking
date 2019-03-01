variable "name" {
  description = "prefix to be appended to some resources"
  default     = "pan-"
}

variable "region" {
  default = "europe-west1"
}

variable "region_zone" {
  default = "europe-west1-b"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

// FIREWALL Variables
variable "firewall_name" {
  default = "fw"
}

variable "image_fw" {
  # default = "Your_VM_Series_Image"
  # /Cloud Launcher API Calls to images/
  # default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-byol-810"
  # default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-bundle2-810"
  default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-bundle1-810"
}

variable "machine_type_fw" {
  default = "n1-standard-4"
}

variable "machine_cpu_fw" {
  default = "Intel Skylake"
}

#variable "bootstrap_bucket_fw" {
#  default = "You_Bootstrap_Bucket_Name"
#}

variable "interface_0_name" {
  default = "management"
}

variable "interface_1_name" {
  default = "untrust"
}

variable "interface_2_name" {
  default = "trust"
}

variable "scopes_fw" {
  default = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
  ]
}

variable "pan_count" {
  default = "2"
}

##################
