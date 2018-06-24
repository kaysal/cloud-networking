variable "project_name" {
  description = "ct-misc-demo"
}

variable "credentials_file_path" {
  description = "C://Users//salawu//SIM//ssh_keys//remote//dedes.pub"
}

variable "public_key_path" {
  description = "Path to SSH public key to be attached to cloud instances"
}

variable "private_key_path" {
  description = "Path to SSH private key"
}

variable "preshared_key" {
  description = "preshaed key used for tunnels 1 and 2"
}

variable "remote_cidr" {
  description = "remote cidr ranges"
}

variable "name" {
    description = "The name of the VPC."
    default = "strongswan"
}
