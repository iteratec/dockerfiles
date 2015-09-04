FROM php:5.6-apache
MAINTAINER Hauke Mettendorf <hauke.mettendorf@iteratec.de>

RUN echo deb http://www.deb-multimedia.org jessie main non-free >> /etc/apt/sources.list && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --force-yes \
    deb-multimedia-keyring \
    imagemagick \
    libjpeg-progs \
    exiftool \
    unzip \
    wget \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libcurl4-openssl-dev \
    python \
    python-pillow && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    ffmpeg && \
    apt-get clean && \
    apt-get autoclean

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install zip && \
    docker-php-ext-install curl && \
    a2enmod expires headers rewrite

RUN apt-get update && apt-get install -y libmagickwand-6.q16-dev --no-install-recommends && \
    ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin && \
    pecl install imagick && \
    echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

RUN cd /tmp && \
    wget https://github.com/iteratec-hh/webpagetest/archive/multistep.zip && \
    unzip multistep.zip && \
    cd webpagetest-multistep && \
    cp -a www/* /var/www/html && \
    rm -rf /tmp/* && \
    chown -R www-data:www-data /var/www/html && \
    cd /var/www/html && \
    #chmod 0750 tmp && \
    chmod 0750 dat && \
    #chmod 0750 results && \
    chmod 0750 -R work && \
    chmod 0750 logs

RUN cd /var/www/html/settings && \
    mv settings.ini.sample settings.ini && \
    mv connectivity.ini.sample connectivity.ini

COPY config/locations.ini /var/www/html/settings/locations.ini

COPY config/php.ini /usr/local/etc/php/

COPY config/apache2.conf /etc/apache2/apache2.conf

VOLUME /var/www/html/settings

EXPOSE 80 443