variable "name" {
  description = "prefix to be appended to some resources"
  default     = "pan-gclb"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "webserver_count" {
  default = "1"
}

##################
