#!/bin/bash

# Sources: https://logz.io/blog/elk-stack-google-cloud/
# https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html

apt-get -y install apt-transport-https

# ELASTIC SEARCH
#=========================
apt-get -y install default-jre
wget -qO - ${ELASTIC_PGP_KEY} | sudo apt-key add -
echo "${ELASTIC_REPO}" | sudo tee -a ${ELASTIC_REPO_FILE}
apt-get update && apt-get install elasticsearch -y
sed -i "s|network\.host.*|network\.host: ${HOST}|" ${ELASTIC_YAML}
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
service elasticsearch start

# LOGSTASH
#=========================
wget -qO - ${PUB_SIG_KEY} | sudo apt-key add -
echo "${ELASTIC_REPO}" | sudo tee -a ${ELASTIC_REPO_FILE}
apt-get update && apt-get install logstash -y
systemctl start logstash.service
/bin/systemctl daemon-reload
/bin/systemctl enable logstash.service
service logstash start

# KIBANA
#=========================
wget -qO - ${PUB_SIG_KEY} | sudo apt-key add -
echo "${ELASTIC_REPO}" | sudo tee -a ${ELASTIC_REPO_FILE}
apt-get update && apt-get install kibana -y
sed -i 's:#\(server.port.*\):\1:' /etc/kibana/kibana.yml
sed -i 's:#\(server.host.*\):\1:' /etc/kibana/kibana.yml
sed -i "s|server\.host.*|server\.host: ${HOST}|" /etc/kibana/kibana.yml
sed -i 's:#\(elasticsearch.hosts.*\):\1:' /etc/kibana/kibana.yml
/bin/systemctl daemon-reload
/bin/systemctl enable kibana.service
service kibana start

# GCP Configuration
#=========================
export PROJECT_ID=$(curl "${METADATA_URL}/project/project-id" -H "${METADATA_HEADER}")
wget https://storage.googleapis.com/salawu-gcs/gcp/instances/logstash.conf -P /etc/logstash/conf.d
sed -i "s|<YOUR-PROJECT-ID>|$PROJECT_ID|" /etc/logstash/conf.d/logstash.conf
/usr/share/logstash/bin/logstash-plugin install logstash-input-google_pubsub
#/usr/share/logstash/bin/logstash-plugin install /tmp/logstash-input-google_pubsub-1.1.0.gem
wget https://storage.googleapis.com/salawu-gcs/gcp/instances/gcp-flowlogs-template.json -P /tmp/
curl -H 'Content-Type: application/json' -XPUT http://localhost:9200/_template/gcp-flowlogs -d@/tmp/gcp-flowlogs-template.json
curl -HEAD localhost:9200/_template/gcp-flowlogs
service logstash restart
#service kibana restart
#service elasticsearch restart
