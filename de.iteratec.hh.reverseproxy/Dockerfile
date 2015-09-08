FROM ubuntu

MAINTAINER Hauke Mettendorf <hauke.mettendorf@proum.de>

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV PATH=$PATH:/scripts

# Update repositories and install apache and nano
# After that apt status information
RUN apt-get update && \
apt-get install -y apache2 nano && \
rm -rf /var/lib/apt/lists/*

# Set ServerName
RUN echo "ServerName localhost" >> /etc/apache2/conf-enabled/hostname.conf

# Enable mods
RUN a2enmod ssl proxy proxy_http proxy_html xml2enc rewrite usertrack

# Deactivate default sites
RUN a2dissite 000-default default-ssl

# Add proxy_html conf
ADD mods-available/proxy_html.conf /etc/apache2/mods-available/proxy_html.conf

# Link file
RUN ln -s /etc/apache2/mods-available/proxy_html.conf /etc/apache2/mods-enabled/proxy_html.conf

# Add example site
ADD sites-available/https-only-example.conf /etc/apache2/sites-available/https-only-example.conf

# Create certificate directories
RUN mkdir -p /etc/ssl/apache/keys && \
mkdir -p /etc/ssl/apache/certs && \
mkdir -p /etc/ssl/apache/intermediates

# Create pid directory
RUN mkdir -p /var/run/apache2

# Set permissions
RUN chmod -R 700 /etc/ssl/apache

# Create script directory
RUN mkdir -p /scripts/sites

# Copy scripts
COPY scripts/migrate-sites /scripts/migrate-sites

# Set execution bit
RUN chmod +x /scripts/migrate-sites

VOLUME ["/etc/ssl/apache2", "/etc/apache2/sites-enabled", "/var/log/apache2", "/etc/apache2/authentication"]

RUN cd /scripts

CMD ["apache2ctl" , "-D", "FOREGROUND"]

EXPOSE 80 443