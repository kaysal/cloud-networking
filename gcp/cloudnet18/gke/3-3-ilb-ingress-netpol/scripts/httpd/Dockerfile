FROM httpd:2.4
WORKDIR ./public-html/
COPY . /usr/local/apache2/htdocs
RUN apt-get update && \
    apt-get install -y \
    tcpdump \
    mtr \
    dnsutils \
    apt-get autoremove
