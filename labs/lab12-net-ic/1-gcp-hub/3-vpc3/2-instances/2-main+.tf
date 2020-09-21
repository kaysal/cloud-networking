
# probe5
#-----------------------

locals {
  probe5_init = templatefile("scripts/probe5.sh.tpl", {
    TARGET = "https-server"
  })
}

resource "google_compute_instance" "probe5" {
  count                     = 5
  name                      = "probe5-${count.index}"
  machine_type              = "f1-micro"
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true

  metadata_startup_script = local.probe5_init

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range5_x.self_link
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# probe6
#-----------------------

locals {
  probe6_init = templatefile("scripts/probe6.sh.tpl", {
    TARGET = "https-server"
  })
}

resource "google_compute_instance" "probe6" {
  name                      = "probe6"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true

  metadata_startup_script = local.probe6_init

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range6_x.self_link
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# probe7
#-----------------------

locals {
  probe7_init = templatefile("scripts/probe7.sh.tpl", {
    TARGET = "proxy-server"
  })
}

resource "google_compute_instance" "probe7" {
  name                      = "probe7"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true

  metadata_startup_script = local.probe7_init

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range7_x.self_link
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# servers
#-----------------------

resource "google_compute_instance" "http_server" {
  name                      = "http-server"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["http-server"]

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range0_x.self_link
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "https_server" {
  name                      = "https-server"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["https-server"]

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range0_x.self_link
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "proxy_server" {
  name                      = "proxy-server"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["proxy-server"]

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range0_x.self_link
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
