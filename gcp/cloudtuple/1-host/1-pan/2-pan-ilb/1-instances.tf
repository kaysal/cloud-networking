# FIREWALL
#==============================
// Create a new PAN-VM instance Zone B
resource "google_compute_instance" "fw_b" {
  name                      = "${var.name}-fw-b"
  machine_type              = "${var.machine_type_fw}"
  zone                      = "europe-west1-b"
  min_cpu_platform          = "${var.machine_cpu_fw}"
  can_ip_forward            = true
  allow_stopping_for_update = true
  tags                      = ["${var.name}"]

  metadata {
    mgmt-interface-swap = "enable"
    serial-port-enable = true
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["cloud-platform"]
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
    network_ip    = "10.0.1.2"
    access_config = {}
  }
  network_interface {
    subnetwork    = "${data.terraform_remote_state.vpc.subnet_mgt}"
    network_ip    = "10.0.0.2"
    access_config = {}
  }
  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.subnet_trust}"
    network_ip = "10.0.2.2"
  }
  boot_disk {
    initialize_params {
      image = "${var.image_fw}"
    }
  }
}

// Create a new PAN-VM instance Zone C
resource "google_compute_instance" "fw_c" {
  name                      = "${var.name}-fw-c"
  machine_type              = "${var.machine_type_fw}"
  zone                      = "europe-west1-c"
  min_cpu_platform          = "${var.machine_cpu_fw}"
  can_ip_forward            = true
  allow_stopping_for_update = true
  tags                      = ["${var.name}"]

  metadata {
    mgmt-interface-swap = "enable"
    serial-port-enable = true
    ssh-keys           = "user:${file("${var.public_key_path}")}"
  }

  service_account {
    scopes = ["cloud-platform"]
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
    network_ip    = "10.0.1.3"
    access_config = {}
  }
  network_interface {
    subnetwork    = "${data.terraform_remote_state.vpc.subnet_mgt}"
    network_ip    = "10.0.0.3"
    access_config = {}
  }
  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.subnet_trust}"
    network_ip = "10.0.2.3"
  }
  boot_disk {
    initialize_params {
      image = "${var.image_fw}"
    }
  }
}
