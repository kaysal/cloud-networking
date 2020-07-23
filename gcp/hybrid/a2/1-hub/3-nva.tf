
# eu1
#-------------------------------------------

# nva1

locals {
  eu1_nva1_init = templatefile("scripts/nva.sh.tpl", {
    ETH0     = var.hub.untrust.eu1.ip.nva1
    ETH1     = var.hub.trust1.ip.nva1
    ILB_80   = var.hub.untrust.eu1.ip.ilb80
    ILB_81   = var.hub.untrust.eu1.ip.ilb81
    DGW1     = var.hub.trust1.ip.dgw
    ONPREM1  = var.onprem.subnet.prv.a
    ONPREM2  = var.onprem.subnet.prv.b
    SPOKE    = var.hub.trust1.cidr.spoke1
    SPOKE_80 = var.hub.trust1.ip.web80
    SPOKE_81 = var.hub.trust1.ip.web81
    SPOKE_NS = var.hub.trust1.ip.ns
  })
}

resource "google_compute_instance" "eu1_nva1" {
  project                   = var.project_id_hub
  name                      = "${var.global.prefix}${var.hub.prefix}eu1-nva1"
  machine_type              = "n1-standard-2"
  zone                      = "${var.hub.region.eu1}-b"
  metadata_startup_script   = local.eu1_nva1_init
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = [var.global.hc_tag]

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.untrust1.self_link
    network_ip = var.hub.untrust.eu1.ip.nva1
    access_config {}
  }

  network_interface {
    subnetwork = google_compute_subnetwork.trust1.self_link
    network_ip = var.hub.trust1.ip.nva1
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# nva2

locals {
  eu1_nva2_init = templatefile("scripts/nva.sh.tpl", {
    ETH0     = var.hub.untrust.eu1.ip.nva2
    ETH1     = var.hub.trust1.ip.nva2
    ILB_80   = var.hub.untrust.eu1.ip.ilb80
    ILB_81   = var.hub.untrust.eu1.ip.ilb81
    DGW1     = var.hub.trust1.ip.dgw
    ONPREM1  = var.onprem.subnet.prv.a
    ONPREM2  = var.onprem.subnet.prv.b
    SPOKE    = var.hub.trust1.cidr.spoke1
    SPOKE_80 = var.hub.trust1.ip.web80
    SPOKE_81 = var.hub.trust1.ip.web81
    SPOKE_NS = var.hub.trust1.ip.ns
  })
}

resource "google_compute_instance" "eu1_nva2" {
  project                   = var.project_id_hub
  name                      = "${var.global.prefix}${var.hub.prefix}eu1-nva2"
  machine_type              = "n1-standard-2"
  zone                      = "${var.hub.region.eu1}-c"
  metadata_startup_script   = local.eu1_nva2_init
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = [var.global.hc_tag]

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.untrust1.self_link
    network_ip = var.hub.untrust.eu1.ip.nva2
    access_config {}
  }

  network_interface {
    subnetwork = google_compute_subnetwork.trust1.self_link
    network_ip = var.hub.trust1.ip.nva2
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# eu2
#-------------------------------------------

# nva1

locals {
  eu2_nva1_init = templatefile("scripts/nva.sh.tpl", {
    ETH0     = var.hub.untrust.eu2.ip.nva1
    ETH1     = var.hub.trust2.ip.nva1
    ILB_80   = var.hub.untrust.eu2.ip.ilb80
    ILB_81   = var.hub.untrust.eu2.ip.ilb81
    DGW1     = var.hub.trust2.ip.dgw
    ONPREM1  = var.onprem.subnet.prv.a
    ONPREM2  = var.onprem.subnet.prv.b
    SPOKE    = var.hub.trust2.cidr.spoke2
    SPOKE_80 = var.hub.trust2.ip.web80
    SPOKE_81 = var.hub.trust2.ip.web81
    SPOKE_NS = var.hub.trust2.ip.ns
  })
}

resource "google_compute_instance" "eu2_nva1" {
  project                   = var.project_id_hub
  name                      = "${var.global.prefix}${var.hub.prefix}eu2-nva1"
  machine_type              = "n1-standard-2"
  zone                      = "${var.hub.region.eu2}-b"
  metadata_startup_script   = local.eu2_nva1_init
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = [var.global.hc_tag]

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.untrust2.self_link
    network_ip = var.hub.untrust.eu2.ip.nva1
    access_config {}
  }

  network_interface {
    subnetwork = google_compute_subnetwork.trust2.self_link
    network_ip = var.hub.trust2.ip.nva1
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# nva2

locals {
  eu2_nva2_init = templatefile("scripts/nva.sh.tpl", {
    ETH0     = var.hub.untrust.eu2.ip.nva2
    ETH1     = var.hub.trust2.ip.nva2
    ILB_80   = var.hub.untrust.eu2.ip.ilb80
    ILB_81   = var.hub.untrust.eu2.ip.ilb81
    DGW1     = var.hub.trust2.ip.dgw
    ONPREM1  = var.onprem.subnet.prv.a
    ONPREM2  = var.onprem.subnet.prv.b
    SPOKE    = var.hub.trust2.cidr.spoke2
    SPOKE_80 = var.hub.trust2.ip.web80
    SPOKE_81 = var.hub.trust2.ip.web81
    SPOKE_NS = var.hub.trust2.ip.ns
  })
}

resource "google_compute_instance" "eu2_nva2" {
  project                   = var.project_id_hub
  name                      = "${var.global.prefix}${var.hub.prefix}eu2-nva2"
  machine_type              = "n1-standard-2"
  zone                      = "${var.hub.region.eu2}-c"
  metadata_startup_script   = local.eu2_nva2_init
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = [var.global.hc_tag]

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.untrust2.self_link
    network_ip = var.hub.untrust.eu2.ip.nva2
    access_config {}
  }

  network_interface {
    subnetwork = google_compute_subnetwork.trust2.self_link
    network_ip = var.hub.trust2.ip.nva2
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
