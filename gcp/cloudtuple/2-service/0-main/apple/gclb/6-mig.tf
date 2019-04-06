# Create multi-zone (regional) managed instance groups
resource "google_compute_region_instance_group_manager" "blue_eu_w1" {
  name               = "${var.main}blue-eu-w1"
  base_instance_name = "${var.main}blue-eu-w1"
  instance_template  = "${google_compute_instance_template.blue_template_eu_w1.self_link}"
  region             = "europe-west1"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "blue_eu_w2" {
  name               = "${var.main}blue-eu-w2"
  base_instance_name = "${var.main}blue-eu-w2"
  instance_template  = "${google_compute_instance_template.blue_template_eu_w2.self_link}"
  region             = "europe-west2"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "green_eu_w1" {
  name               = "${var.main}green-eu-w1"
  base_instance_name = "${var.main}green-eu-w1"
  instance_template  = "${google_compute_instance_template.green_template_eu_w1.self_link}"
  region             = "europe-west1"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "green_eu_w2" {
  name               = "${var.main}green-eu-w2"
  base_instance_name = "${var.main}green-eu-w2"
  instance_template  = "${google_compute_instance_template.green_template_eu_w2.self_link}"
  region             = "europe-west2"

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_region_instance_group_manager" "dev_eu_w3" {
  name               = "${var.main}dev-eu-w3"
  base_instance_name = "${var.main}dev-eu-w3"
  instance_template  = "${google_compute_instance_template.dev_template_eu_w3.self_link}"
  region             = "europe-west3"

  named_port {
    name = "http"
    port = "80"
  }
}

# Create regional autoscalers
resource "google_compute_region_autoscaler" "autoscaler_blue_eu_w1" {
  name   = "${var.main}autoscaler-blue-eu-w1"
  region = "europe-west1"
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
  name   = "${var.main}autoscaler-blue-eu-w2"
  region = "europe-west2"
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
  name   = "${var.main}autoscaler-green-eu-w1"
  region = "europe-west1"
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
  name   = "${var.main}autoscaler-green-eu-w2"
  region = "europe-west2"
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

resource "google_compute_region_autoscaler" "autoscaler_dev_eu_w3" {
  name   = "${var.main}autoscaler-dev-eu-w3"
  region = "europe-west3"
  target = "${google_compute_region_instance_group_manager.dev_eu_w3.self_link}"

  autoscaling_policy = {
    max_replicas    = 1
    min_replicas    = 1
    cooldown_period = 45

    cpu_utilization {
      target = 0.2
    }
  }
}
