# elk host
#============================
data "template_file" "elk_init" {
  template = "${file("scripts/elk.sh.tpl")}"

  vars {
    HOST              = "0.0.0.0"
    ELASTIC_PGP_KEY   = "https://packages.elastic.co/GPG-KEY-elasticsearch"
    ELASTIC_REPO      = "deb https://artifacts.elastic.co/packages/6.x/apt stable main"
    ELASTIC_REPO_FILE = "/etc/apt/sources.list.d/elastic-6.x.list"
    ELASTIC_YAML      = "/etc/elasticsearch/elasticsearch.yml"
    PUB_SIG_KEY       = "https://artifacts.elastic.co/GPG-KEY-elasticsearch"
    METADATA_URL      = "http://metadata.google.internal/computeMetadata/v1"
    METADATA_HEADER   = "Metadata-Flavor: Google"
  }
}

resource "google_compute_instance" "elk_stack" {
  name                      = "${var.name}elk-stack"
  machine_type              = "n1-standard-4"
  zone                      = "europe-west1-c"
  tags                      = ["elk"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      type  = "pd-ssd"
      size  = "100"
    }
  }

  network_interface {
    subnetwork = "${data.terraform_remote_state.vpc.apple_eu_w1_10_100_10}"

    access_config {
      // ephemeral nat ip
    }
  }

  metadata_startup_script = "${data.template_file.elk_init.rendered}"

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_dns_record_set" "elk_public" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "elk.host.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.elk_stack.network_interface.0.access_config.0.nat_ip}"]
}
