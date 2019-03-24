FROM php:7.2-apache

RUN cd
ADD storage.py .
RUN chmod +x storage.py

RUN apt-get update && apt-get install -y \
  wget vim python3 python3-pip

RUN pip3 install --upgrade google-cloud-storage

RUN cd /var/www/html/
RUN rm index.html -f
RUN rm index.php -f
RUN wget https://storage.googleapis.com/salawu-gcs/gcp/images/favicons/tcp/favicon.ico
#RUN wget https://storage.googleapis.com/salawu-gcs/gcp/instances/gke/docker/index.php
COPY index.php .
RUN IMAGE=https://storage.googleapis.com/salawu-gcs/gcp/images/debug.png
RUN sed -i 's|image-here|https://storage.googleapis.com/salawu-gcs/gcp/images/debug.png|' index.php
RUN sed -i '/Listen 80/c\Listen 8080' /etc/apache2/ports.conf
RUN apt-get clean
EXPOSE 80 8080
CMD ["apache2ctl", "-D", "FOREGROUND"]
