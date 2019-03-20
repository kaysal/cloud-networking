# Service Accounts - Host Project
#-----------------------------------------------
data "google_service_account" "vm_host_project" {
  account_id = "compute-engine"
  project    = "${data.terraform_remote_state.host.host_project_id}"
}

data "google_service_account" "tf_host_project" {
  account_id = "terraform"
  project    = "${data.terraform_remote_state.host.host_project_id}"
}

# Service Accounts - Apple Project
#-----------------------------------------------
data "google_service_account" "vm_apple_service_project" {
  account_id = "compute-engine"
  project    = "${data.terraform_remote_state.apple.apple_service_project_id}"
}

data "google_service_account" "tf_apple_service_project" {
  account_id = "terraform"
  project    = "${data.terraform_remote_state.apple.apple_service_project_id}"
}

# Service Accounts - Orange Project
#-----------------------------------------------
data "google_service_account" "vm_orange_project" {
  account_id = "compute-engine"
  project    = "${data.terraform_remote_state.orange.orange_project_id}"
}

data "google_service_account" "tf_orange_project" {
  account_id = "terraform"
  project    = "${data.terraform_remote_state.orange.orange_project_id}"
}

# Service Accounts - Mango Project
#-----------------------------------------------
data "google_service_account" "vm_mango_project" {
  account_id = "compute-engine"
  project    = "${data.terraform_remote_state.mango.mango_project_id}"
}

data "google_service_account" "tf_mango_project" {
  account_id = "terraform"
  project    = "${data.terraform_remote_state.mango.mango_project_id}"
}

# Service Accounts - GKE Project
#-----------------------------------------------
data "google_service_account" "node_gke_service_project" {
  account_id = "gke-node"
  project    = "${data.terraform_remote_state.gke.gke_service_project_id}"
}

data "google_service_account" "tf_gke_service_project" {
  account_id = "terraform"
  project    = "${data.terraform_remote_state.gke.gke_service_project_id}"
}

data "google_service_account" "k8s_app_gke_service_project" {
  account_id = "k8sapp"
  project    = "${data.terraform_remote_state.gke.gke_service_project_id}"
}

# capture local machine ipv4 to use in security configuration
#-----------------------------------------------
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

# GFE LB IP ranges
#-----------------------------------------------
data "google_compute_lb_ip_ranges" "ranges" {}

output "nlb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.network}"
}

output "gclb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"
}

# netblock
#-----------------------------------------------
data "google_netblock_ip_ranges" "netblock" {}

/*
output "cidr_blocks" {
  value = "${data.google_netblock_ip_ranges.netblock.cidr_blocks}"
}

output "cidr_blocks_ipv4" {
  value = "${data.google_netblock_ip_ranges.netblock.cidr_blocks_ipv4}"
}

output "cidr_blocks_ipv6" {
  value = "${data.google_netblock_ip_ranges.netblock.cidr_blocks_ipv6}"
}*/

