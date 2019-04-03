output "pubsub_topic" {
  description = "PubSub topic name"
  value       = "${google_pubsub_topic.logstash_input_dev.name}"
}

output "elk_nat_ip" {
  value = "${google_compute_instance.elk_stack.network_interface.0.access_config.0.nat_ip}"
}
