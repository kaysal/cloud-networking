variable "name" {
  description = "prefix to be appended to some resources"
  default     = "pan-gclb"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
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

