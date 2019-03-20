#!/bin/bash -xe

export PROJECT_ID=host-project-39
mv /opt/bitnami/logstash/conf/logstash.conf /opt/bitnami/logstash/conf/logstash.bak
touch /opt/bitnami/logstash/conf/logstash.conf
cat <<EOF >>/opt/bitnami/logstash/conf/logstash.conf
input
{
    google_pubsub {
        project_id => "<YOUR-PROJECT-ID>"
        topic => "logstash-input-dev"
        subscription => "gcp-flowlogs"
        type => "pubsub"
    }
}

filter {
      json {
        source => "message"
      }

     mutate {
      remove_field => ["message"]
      remove_field => ["type"]
      rename => { "[jsonPayload][bytes_sent]" => "bytes_sent" }
      rename => { "[jsonPayload][connection][dest_ip]" => "conn.dest_ip" }
      rename => { "[jsonPayload][connection][dest_port]" => "conn.dest_port" }
      rename => { "[jsonPayload][connection][protocol]" => "conn.protocol" }
      rename => { "[jsonPayload][connection][src_ip]" => "conn.src_ip" }
      rename => { "[jsonPayload][connection][src_port]" => "conn.src_port" }
      rename => { "[jsonPayload][disposition]" => "conn.disposition" }
      rename => { "[jsonPayload][instance][project_id]" => "instance.project_id" }
      rename => { "[jsonPayload][instance][region]" => "instance.region" }
      rename => { "[jsonPayload][instance][vm_name]" => "instance.vm_name" }
      rename => { "[jsonPayload][instance][zone]" => "instance.zone" }
      rename => { "[jsonPayload][remote_location][continent]" => "remote.continent" }
      rename => { "[jsonPayload][remote_location][country]" => "remote.country" }
      rename => { "[jsonPayload][rule_details][action]" => "rule.action" }
      rename => { "[jsonPayload][rule_details][direction]" => "rule.direction" }
      rename => { "[jsonPayload][rule_details][ip_port_info]" => "rule.ip_port" }
      rename => { "[jsonPayload][rule_details][priority]" => "rule.priority" }
      rename => { "[jsonPayload][rule_details][source_range]" => "rule.source_range" }
      rename => { "[jsonPayload][rule_details][target_tag]" => "rule.target_tag" }
      rename => { "[jsonPayload][vpc][project_id]" => "vpc.project_id" }
      rename => { "[jsonPayload][vpc][subnetwork_name]" => "vpc.subnet_name" }
      rename => { "[jsonPayload][vpc][vpc_name]" => "vpc.vpc_name" }
      rename => { "[jsonPayload][src_instance][project_id]" => "src_inst.project_id" }
      rename => { "[jsonPayload][src_instance][region]" => "src_inst.region" }
      rename => { "[jsonPayload][src_instance][vm_name]" => "src_inst.vm_name" }
      rename => { "[jsonPayload][src_instance][zone]" => "src_inst.zone" }
      rename => { "[jsonPayload][src_vpc][project_id]" => "src_vpc.project_id" }
      rename => { "[jsonPayload][src_vpc][subnetwork_name]" => "src_vpc.subnetwork_name" }
      rename => { "[jsonPayload][src_vpc][vpc_name]" => "src_vpc.vpc_name" }
      rename => { "[jsonPayload][dest_instance][project_id]" => "dest_inst.project_id" }
      rename => { "[jsonPayload][dest_instance][region]" => "dest_inst.region" }
      rename => { "[jsonPayload][dest_instance][vm_name]" => "dest_inst.vm_name" }
      rename => { "[jsonPayload][dest_instance][zone]" => "dest_inst.zone" }
      rename => { "[jsonPayload][dest_vpc][project_id]" => "dest_vpc.project_id" }
      rename => { "[jsonPayload][dest_vpc][subnetwork_name]" => "dest_vpc.subnetwork_name" }
      rename => { "[jsonPayload][dest_vpc][vpc_name]" => "dest_vpc.vpc_name" }
      rename => { "[jsonPayload][end_time]" => "end_time" }
      rename => { "[jsonPayload][packets_sent]" => "packets_sent" }
      rename => { "[jsonPayload][reporter]" => "reporter" }
      rename => { "[jsonPayload][rtt_msec]" => "rtt_msec" }
      rename => { "[jsonPayload][start_time]" => "start_time" }
      rename => { "[jsonPayload][dest_location][asn]" => "dest_location.asn" }
      rename => { "[jsonPayload][dest_location][city]" => "dest_location.city" }
      rename => { "[jsonPayload][dest_location][continent]" => "dest_location.continent" }
      rename => { "[jsonPayload][dest_location][country]" => "dest_location.country" }
      rename => { "[jsonPayload][dest_location][region]" => "dest_location.region" }
      rename => { "[jsonPayload][src_location][asn]" => "src_location.asn" }
      rename => { "[jsonPayload][src_location][city]" => "src_location.city" }
      rename => { "[jsonPayload][src_location][continent]" => "src_location.continent" }
      rename => { "[jsonPayload][src_location][country]" => "src_location.country" }
      rename => { "[jsonPayload][src_location][region]" => "src_location.region" }
      rename => { "[resource][labels][location]" => "labels.location" }
      rename => { "[resource][labels][project_id]" => "labels.project_id" }
      rename => { "[resource][labels][subnetwork_id]" => "labels.subnetwork_id" }
      rename => { "[resource][labels][subnetwork_name]" => "labels.subnetwork_name" }
      rename => { "[resource][labels][gateway_id]" => "labels.gateway_id" }
      rename => { "[resource][type]" => "resource_type" }
      rename => { "[severity]" => "severity" }
      rename => { "[textPayload]" => "ipsec_text_payload" }
      rename => { "[jsonPayload][actor][user]" => "actor.user" }
      rename => { "[jsonPayload][event_subtype]" => "event_subtype" }
      rename => { "[jsonPayload][event_timestamp_us]" => "event_timestamp_us" }
      rename => { "[jsonPayload][event_type]" => "event_type" }
      rename => { "[jsonPayload][ip_address]" => "ip_address" }
      rename => { "[jsonPayload][operation][global]" => "operation.global" }
      rename => { "[jsonPayload][operation].[id]" => "operation.id" }
      rename => { "[jsonPayload][operation][name]" => "operation.name" }
      rename => { "[jsonPayload][operation][region]" => "operation.region" }
      rename => { "[jsonPayload][operation][type]" => "operation.type" }
      rename => { "[jsonPayload][request][body]" => "request.body" }
      rename => { "[jsonPayload][request][url]" => "request.url" }
      rename => { "[jsonPayload][resource][id]" => "resource.id" }
      rename => { "[jsonPayload][resource][name]" => "resource.name" }
      rename => { "[jsonPayload][resource][region]" => "resource.region" }
      rename => { "[jsonPayload][resource][type]" => "resource.type" }
      rename => { "[jsonPayload][trace_id]" => "trace_id" }
      rename => { "[jsonPayload][user_agent]" => "user_agent" }
      rename => { "[jsonPayload][version]" => "version" }
      rename => { "[labels][compute.googleapis.com/resource_id]" => "labels.resource_id" }
      rename => { "[labels][compute.googleapis.com/resource_name]" => "labels.resource_name" }
      rename => { "[labels][compute.googleapis.com/resource_type]" => "labels.resource_type" }
      rename => { "[labels][tunnel_id]" => "labels.tunnel_id" }
     }
}

output
{
    elasticsearch
    {
        hosts => ["127.0.0.1:9200"]
        index => "gcp-flowlogs-%{+YYYY.MM.dd}"
    }
}
EOF
sed -i "s|<YOUR-PROJECT-ID>|$PROJECT_ID|" /opt/bitnami/logstash/conf/logstash.conf
curl -L -o /tmp/logstash-input-google_pubsub-1.1.0.gem https://rubygems.org/downloads/logstash-input-google_pubsub-1.1.0.gem
/opt/bitnami/logstash/bin/logstash-plugin install /tmp/logstash-input-google_pubsub-1.1.0.gem
/opt/bitnami/ctlscript.sh restart logstash

touch /tmp/gcp-flowlogs-template.json
cat <<EOF >>/tmp/gcp-flowlogs-template.json

EOF

curl -H 'Content-Type: application/json' -XPUT http://localhost:9200/_template/gcp-flowlogs -d@/tmp/gcp-flowlogs-template.json
curl -HEAD localhost:9200/_template/gcp-flowlogs
