FROM haproxy:3.1.1

ARG USER_UID
ARG USER_GID
ARG PUBLIC_DOMAIN
ENV PUBLIC_DOMAIN=${PUBLIC_DOMAIN}

# Add directory for modsec installation
USER root
RUN mkdir --parents "/opt/owasp/crs/rules"

# Update and install basic packages
RUN apt-get update && apt-get -y install curl wget nano software-properties-common \
tzdata apt-utils git procps unzip make

# Copy OWASP rules and config for modsecurity
COPY common/owasp/rules/*.data /opt/owasp/crs/rules/
COPY common/owasp/rules/*.conf /opt/owasp/crs/rules/
COPY common/owasp/crs-setup.conf /opt/owasp/crs/crs-setup.conf
# COPY common/owasp-master.conf /opt/owasp/crs/owasp-master.conf

COPY haproxy/01-haproxy-config.sh /01-haproxy-config.sh
RUN chmod +x /01-haproxy-config.sh
RUN /01-haproxy-config.sh