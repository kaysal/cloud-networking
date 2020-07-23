
# onprem.lab.

resource "google_dns_managed_zone" "onprem_to_onprem" {
  provider    = google-beta
  project     = var.project_id_onprem
  name        = "${var.global.prefix}${var.onprem.prefix}to-onprem"
  dns_name    = "onprem.lab."
  description = "*.onprem.lab > [unbound]"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = local.onprem.network.self_link
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = var.onprem.eu1.ip.ns
    }
  }
}

# *.spoke1.lab

resource "google_dns_managed_zone" "onprem_to_spoke1" {
  provider    = google-beta
  project     = var.project_id_onprem
  name        = "${var.global.prefix}${var.onprem.prefix}to-spoke1"
  dns_name    = "spoke1.lab."
  description = "*.spoke1.lab > [spoke1 dns]"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = local.onprem.network.self_link
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = var.onprem.eu1.ip.proxy
    }
  }
}

# *.spoke2.lab

resource "google_dns_managed_zone" "onprem_to_spoke2" {
  provider    = google-beta
  project     = var.project_id_onprem
  name        = "${var.global.prefix}${var.onprem.prefix}to-spoke2"
  dns_name    = "spoke2.lab."
  description = "*.spoke2.lab > [spoke2 dns]"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = local.onprem.network.self_link
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = var.onprem.eu2.ip.proxy
    }
  }
}

# queries for "." forwarded to onprem unbound server

resource "google_dns_managed_zone" "onprem_to_all" {
  provider    = google-beta
  project     = var.project_id_onprem
  name        = "${var.global.prefix}${var.onprem.prefix}to-all"
  dns_name    = "."
  description = " '.' > [unbound]"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = local.onprem.network.self_link
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = var.onprem.eu1.ip.ns
    }
  }
}
