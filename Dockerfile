FROM php:7.4-apache

ENV CUSER=domainmod
ENV LOCALE1="en_CA.UTF-8"
ENV LOCALE2="en_US.UTF-8"
ENV LOCALE3="de_DE.UTF-8"
ENV LOCALE4="es_ES.UTF-8"
ENV LOCALE5="fr_FR.UTF-8"
ENV LOCALE6="it_IT.UTF-8"
ENV LOCALE7="nl_NL.UTF-8"
ENV LOCALE8="pl_PL.UTF-8"
ENV LOCALE9="pt_PT.UTF-8"
ENV LOCALE10="ru_RU.UTF-8"
ENV PGID=1000
ENV PUID=1000
RUN groupadd --gid "${PGID}" -r $CUSER && useradd -u "${PUID}" -r -g $CUSER -d /usr/src/$CUSER -s /sbin/nologin -c "Docker Image User" $CUSER \
    && apt-get update \
    && apt-get install -y \ 
       cron \
       curl \
       gettext \
       libxml2 \
       libxml2-dev \
       locales \
       tzdata \
       git \
    && docker-php-ext-install \
       gettext \
       mysqli \
       pdo \
       pdo_mysql \
       simplexml \
    && apt-get clean -y \
    && rm -Rf /var/lib/apt/lists/*
RUN curl -sSL -o /tmp/mo https://git.io/get-mo && \
    chmod +x /tmp/mo
RUN sed -i 's/^exec /service cron start\n\nexec /' /usr/local/bin/apache2-foreground \
    && sed -i -e "s/# $LOCALE1/$LOCALE1/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE2/$LOCALE2/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE3/$LOCALE3/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE4/$LOCALE4/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE5/$LOCALE5/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE6/$LOCALE6/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE7/$LOCALE7/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE8/$LOCALE8/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE9/$LOCALE9/" /etc/locale.gen \
    && sed -i -e "s/# $LOCALE10/$LOCALE10/" /etc/locale.gen \ 
    && locale-gen \
    && echo "LANG=$LOCALE1" > /etc/default/locale
ENV LANG $LOCALE1
ENV LC_ALL $LOCALE1
COPY cron /etc/cron.d/cron
COPY entrypoint.sh /usr/local/bin
COPY php.ini /usr/local/etc/php/php.ini

# COPY source/ /var/www/new_version/
# RUN git clone https://github.com/domainmod/domainmod.git /var/www/new_version/
COPY test/ /var/www/html

# RUN chmod 0644 /etc/cron.d/cron \
#     && crontab /etc/cron.d/cron \
#     && mkdir -p /var/log/cron \
#     && chmod +x /usr/local/bin/entrypoint.sh

# Apache
ENV HTTP_PORT 8080

COPY config/apache/ports.conf.mo /tmp
RUN /tmp/mo /tmp/ports.conf.mo > /etc/apache2/ports.conf
COPY config/apache/dmodsaml.conf.mo /tmp
RUN /tmp/mo /tmp/dmodsaml.conf.mo > /etc/apache2/sites-available/dmodsaml.conf

RUN a2dissite 000-default.conf default-ssl.conf && \
    a2enmod rewrite && \
    a2ensite dmodsaml.conf

# Clean up
RUN rm -rf /tmp/*

# Set working directory
# WORKDIR /var/www/

EXPOSE ${HTTP_PORT}
# ENTRYPOINT ["bash", "entrypoint.sh"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]