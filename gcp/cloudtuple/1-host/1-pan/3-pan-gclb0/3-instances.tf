# firewall
#==============================
// Create a new PAN-VM instance
resource "google_compute_instance" "fw" {
  name                      = "${var.name}${var.firewall_name}${count.index + 1}"
  machine_type              = "${var.machine_type_fw}"
  zone                      = "${var.zone}"
  min_cpu_platform          = "${var.machine_cpu_fw}"
  can_ip_forward            = true
  allow_stopping_for_update = true
  tags                      = ["pan", "trust", "untrust", "mgt"]
  count                     = "${var.pan_count}"

  metadata {
    // initconfig.txt will perform interface swap of VM-series on bootstrap
    # vmseries-bootstrap-gce-storagebucket = "${google_storage_bucket.bootstrap_bucket.name}"
    mgmt-interface-swap = "enable"
    serial-port-enable = true
    ssh-keys            = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = "${var.scopes_fw}"
  }

  // Swapped Interface for Load Balancer
  # before swap:
  # nic0 -> untrust -> eth1/0 [PAN MGT]
  # nic1 -> mgt -> eth1/1 [PAN UNTRUST]
  # nic2 -> trust -> eth1/1 [PAN TRUST]
  # after swap:
  # nic0 -> untrust -> eth1/1 [PAN UNTRUST]
  # nic1 -> mgt -> eth1/0 [PAN MGT]
  # nic2 -> trust -> eth1/1 [PAN TRUST]

  network_interface {
    subnetwork    = "${data.terraform_remote_state.vpc.subnet_untrust}"
    network_ip    = "10.0.1.${count.index + 2}"
    access_config = {}
  }
  network_interface {
    subnetwork    = "${data.terraform_remote_state.vpc.subnet_mgt}"
    network_ip    = "10.0.0.${count.index + 2}"
    access_config = {}
  }
  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.subnet_trust}"
    network_ip = "10.0.2.${count.index + 2}"
  }
  boot_disk {
    initialize_params {
      image = "${var.image_fw}"
    }
  }
}
