provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../1-vpc/terraform.tfstate"
  }
}

locals {
  vpc3 = data.terraform_remote_state.network.outputs.network.vpc3
  subnet = {
    range1   = data.terraform_remote_state.network.outputs.subnetwork.us.range1
    range2   = data.terraform_remote_state.network.outputs.subnetwork.us.range2
    range3   = data.terraform_remote_state.network.outputs.subnetwork.us.range3
    range4   = data.terraform_remote_state.network.outputs.subnetwork.us.range4
    range5   = data.terraform_remote_state.network.outputs.subnetwork.us.range5
    range6   = data.terraform_remote_state.network.outputs.subnetwork.us.range6
    range7   = data.terraform_remote_state.network.outputs.subnetwork.us.range7
    range8   = data.terraform_remote_state.network.outputs.subnetwork.us.range8
    range9   = data.terraform_remote_state.network.outputs.subnetwork.us.range9
    range10  = data.terraform_remote_state.network.outputs.subnetwork.us.range10
    range0_x = data.terraform_remote_state.network.outputs.subnetwork.us.range0_x
    range1_x = data.terraform_remote_state.network.outputs.subnetwork.us.range1_x
    range2_x = data.terraform_remote_state.network.outputs.subnetwork.us.range2_x
    range3_x = data.terraform_remote_state.network.outputs.subnetwork.us.range3_x
    range4_x = data.terraform_remote_state.network.outputs.subnetwork.us.range4_x
    range5_x = data.terraform_remote_state.network.outputs.subnetwork.us.range5_x
    range6_x = data.terraform_remote_state.network.outputs.subnetwork.us.range6_x
    range7_x = data.terraform_remote_state.network.outputs.subnetwork.us.range7_x
  }
}

# use case 1
#-------------------------------------------

locals {
  vm1_init = templatefile("scripts/vm1.sh.tpl", {
    TARGET = "vm2"
  })
}

resource "google_compute_instance" "vm1" {
  name                      = "vm1"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["web-app1"]

  metadata_startup_script = local.vm1_init

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range1.self_link
    network_ip = var.hub.vpc3.us.ip.vm1
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "vm2" {
  name                      = "vm2"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["web-app2"]

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range2.self_link
    network_ip = var.hub.vpc3.us.ip.vm2
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

locals {
  vm3_init = templatefile("scripts/vm3.sh.tpl", {
    TARGET1 = "vm4"
    TARGET2 = "vm6"
  })
}

resource "google_compute_instance" "vm3" {
  name                      = "vm3"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["server3"]

  metadata_startup_script = local.vm3_init

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range3.self_link
    network_ip = var.hub.vpc3.us.ip.vm3
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "vm4" {
  name                      = "vm4"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["db-srv4"]

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range4.self_link
    network_ip = var.hub.vpc3.us.ip.vm4
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# use case 2
#-------------------------------------------

locals {
  vm5_init = templatefile("scripts/vm5.sh.tpl", {
    TARGET = "vm6"
  })
}

resource "google_compute_instance" "vm5" {
  name                      = "vm5"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["server5"]

  metadata_startup_script = local.vm5_init

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range5.self_link
    network_ip = var.hub.vpc3.us.ip.vm5
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "vm6" {
  name                      = "vm6"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["auth-srv6"]

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range6.self_link
    network_ip = var.hub.vpc3.us.ip.vm6
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# use case 3
#-------------------------------------------

locals {
  vm7_init = templatefile("scripts/vm7.sh.tpl", {
    TARGET = "vm8"
  })
}

resource "google_compute_instance" "vm7" {
  name                      = "vm7"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["server7"]

  metadata_startup_script = local.vm7_init

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range7.self_link
    network_ip = var.hub.vpc3.us.ip.vm7
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "vm8" {
  name                      = "vm8"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["anthos8-fw", "db8-mysql"]

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range8.self_link
    network_ip = var.hub.vpc3.us.ip.vm8
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# use case 4
#-------------------------------------------

locals {
  vm9_init = templatefile("scripts/vm9.sh.tpl", {
    TARGET = data.terraform_remote_state.vpc3.outputs.vm10_public_ip
  })
}

resource "google_compute_instance" "vm9" {
  name                      = "vm9"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["server9"]

  metadata_startup_script = local.vm9_init

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range9.self_link
    network_ip = var.hub.vpc3.us.ip.vm9
    access_config {
      nat_ip = data.terraform_remote_state.vpc3.outputs.vm9_public_ip
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  depends_on = [google_compute_instance.vm10]
}

resource "google_compute_instance" "vm10" {
  name                      = "vm10"
  machine_type              = var.global.standard_machine
  zone                      = "${var.hub.vpc3.us.region}-b"
  allow_stopping_for_update = true
  tags                      = ["web-app10"]

  boot_disk {
    initialize_params {
      image = var.global.image.debian
    }
  }

  network_interface {
    subnetwork = local.subnet.range10.self_link
    network_ip = var.hub.vpc3.us.ip.vm10
    access_config {
      nat_ip = data.terraform_remote_state.vpc3.outputs.vm10_public_ip
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
