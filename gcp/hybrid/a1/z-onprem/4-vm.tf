
locals {
  vm_init = templatefile("scripts/web.sh.tpl", {
    ILB_UNTRUST1_80 = var.hub.untrust.eu1.ip.ilb80
    ILB_UNTRUST1_81 = var.hub.untrust.eu1.ip.ilb81
    ILB_UNTRUST2_80 = var.hub.untrust.eu2.ip.ilb80
    ILB_UNTRUST2_81 = var.hub.untrust.eu2.ip.ilb81
  })
}

# vm eu1

resource "google_compute_instance" "vm_eu1" {
  name                      = "${var.global.prefix}${var.onprem.prefix}vm-eu1"
  machine_type              = "n1-standard-1"
  zone                      = "${var.onprem.eu1.region}-b"
  metadata_startup_script   = local.vm_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.onprem_eu1.self_link
    network_ip = var.onprem.eu1.ip.vm
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = google_service_account.onprem_sa.email
  }
}

# vm eu2

resource "google_compute_instance" "vm_eu2" {
  name                      = "${var.global.prefix}${var.onprem.prefix}vm-eu2"
  machine_type              = "n1-standard-1"
  zone                      = "${var.onprem.eu2.region}-b"
  metadata_startup_script   = local.vm_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.onprem_eu2.self_link
    network_ip = var.onprem.eu2.ip.vm
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = google_service_account.onprem_sa.email
  }
}

# unbound dns server

locals {
  unbound_init = templatefile("scripts/unbound.sh.tpl", {
    DNS_NAME1    = "vm.eu1.onprem.lab"
    DNS_NAME2    = "vm.eu2.onprem.lab"
    DNS_NAME3    = "ns.eu1.onprem.lab"
    DNS_NAME4    = "web80.spoke1.lab"
    DNS_NAME5    = "web81.spoke1.lab"
    DNS_NAME6    = "web80.spoke2.lab"
    DNS_NAME7    = "web81.spoke2.lab"
    A_RECORD1    = var.onprem.eu1.ip.vm
    A_RECORD2    = var.onprem.eu2.ip.vm
    A_RECORD3    = var.onprem.eu1.ip.ns
    A_RECORD4    = var.spoke1.ip.web80
    A_RECORD5    = var.spoke1.ip.web80
    A_RECORD6    = var.spoke2.ip.web80
    A_RECORD7    = var.spoke2.ip.web80
    SPOKE1_DNS   = "spoke1.lab."
    SPOKE2_DNS   = "spoke2.lab."
    SPOKE1_FWD   = var.spoke1.ip.dns
    SPOKE2_FWD   = var.spoke2.ip.dns
    EGRESS_PROXY = "35.199.192.0/19"
  })
}

resource "google_compute_instance" "onprem_ns" {
  project                   = var.project_id_onprem
  name                      = "${var.global.prefix}${var.onprem.prefix}ns"
  machine_type              = "n1-standard-1"
  zone                      = "${var.onprem.eu1.region}-b"
  metadata_startup_script   = local.unbound_init
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.onprem_eu1.self_link
    network_ip = var.onprem.eu1.ip.ns
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = google_service_account.onprem_sa.email
  }
}

# dns proxy

locals {
  onprem_proxy_eu1_init = templatefile("scripts/proxy.sh.tpl", {
    ETH0     = var.onprem.eu1.ip.proxy
    SPOKE_NS = var.spoke1.ip.dns
  })
}

resource "google_compute_instance" "onprem_dns_proxy_eu1" {
  project                   = var.project_id_onprem
  name                      = "${var.global.prefix}${var.onprem.prefix}proxy1"
  machine_type              = "n1-standard-1"
  zone                      = "${var.onprem.eu1.region}-b"
  can_ip_forward            = true
  allow_stopping_for_update = true
  metadata_startup_script   = local.onprem_proxy_eu1_init

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.onprem_eu1.self_link
    network_ip = var.onprem.eu1.ip.proxy
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = google_service_account.onprem_sa.email
  }
}

locals {
  onprem_proxy_eu2_init = templatefile("scripts/proxy.sh.tpl", {
    ETH0     = var.onprem.eu2.ip.proxy
    SPOKE_NS = var.spoke2.ip.dns
  })
}

resource "google_compute_instance" "onprem_dns_proxy_eu2" {
  project                   = var.project_id_onprem
  name                      = "${var.global.prefix}${var.onprem.prefix}proxy2"
  machine_type              = "n1-standard-1"
  zone                      = "${var.onprem.eu2.region}-b"
  can_ip_forward            = true
  allow_stopping_for_update = true
  metadata_startup_script   = local.onprem_proxy_eu2_init

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.onprem_eu2.self_link
    network_ip = var.onprem.eu2.ip.proxy
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = google_service_account.onprem_sa.email
  }
}
