
# Create multi-zone (regional) managed instance groups
resource "google_compute_region_instance_group_manager" "blue_eu_w1" {
  name               = "${var.name}blue-eu-w1"
  base_instance_name = "${var.name}blue-eu-w1"
  instance_template  = "${google_compute_instance_template.blue_template_eu_w1.self_link}"
  region       = "europe-west1"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "blue_eu_w2" {
  name               = "${var.name}blue-eu-w2"
  base_instance_name = "${var.name}blue-eu-w2"
  instance_template  = "${google_compute_instance_template.blue_template_eu_w2.self_link}"
  region       = "europe-west2"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "green_eu_w1" {
  name               = "${var.name}green-eu-w1"
  base_instance_name = "${var.name}green-eu-w1"
  instance_template  = "${google_compute_instance_template.green_template_eu_w1.self_link}"
  region       = "europe-west1"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "green_eu_w2" {
  name               = "${var.name}green-eu-w2"
  base_instance_name = "${var.name}green-eu-w2"
  instance_template  = "${google_compute_instance_template.green_template_eu_w2.self_link}"
  region       = "europe-west2"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "dev_us_e1" {
  name               = "${var.name}dev-us-e1"
  base_instance_name = "${var.name}dev-us-e1"
  instance_template  = "${google_compute_instance_template.dev_template_us_e1.self_link}"
  region       = "us-east1"

  named_port {
    name = "http"
    port = "80"
  }
}

# Create regional autoscalers
resource "google_compute_region_autoscaler" "autoscaler_blue_eu_w1" {
  name   = "${var.name}autoscaler-blue-eu-w1"
  region       = "europe-west1"
  target = "${google_compute_region_instance_group_manager.blue_eu_w1.self_link}"

  autoscaling_policy = {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.2
    }
  }
}

resource "google_compute_region_autoscaler" "autoscaler_blue_eu_w2" {
  name   = "${var.name}autoscaler-blue-eu-w2"
  region       = "europe-west2"
  target = "${google_compute_region_instance_group_manager.blue_eu_w2.self_link}"

  autoscaling_policy = {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.2
    }
  }
}

resource "google_compute_region_autoscaler" "autoscaler_green_eu_w1" {
  name   = "${var.name}autoscaler-green-eu-w1"
  region       = "europe-west1"
  target = "${google_compute_region_instance_group_manager.green_eu_w1.self_link}"

  autoscaling_policy = {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.2
    }
  }
}

resource "google_compute_region_autoscaler" "autoscaler_green_eu_w2" {
  name   = "${var.name}autoscaler-green-eu-w2"
  region       = "europe-west2"
  target = "${google_compute_region_instance_group_manager.green_eu_w2.self_link}"

  autoscaling_policy = {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.2
    }
  }
}

resource "google_compute_region_autoscaler" "autoscaler_dev_us_e1" {
  name   = "${var.name}autoscaler-dev-us-e1"
  region       = "us-east1"
  target = "${google_compute_region_instance_group_manager.dev_us_e1.self_link}"

  autoscaling_policy = {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.2
    }
  }
}
