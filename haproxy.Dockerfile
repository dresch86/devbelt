FROM haproxy:2.5
COPY common/ssl/ /etc/ssl/certs/

ARG PUBLIC_DOMAIN
ENV PUBLIC_DOMAIN=${PUBLIC_DOMAIN}

# Add directory for modsec installation
USER root
RUN mkdir --parents "/opt/modsec/owasp/crs/rules"

# Copy OWASP rules and config for modsecurity
# COPY common/modsec/owasp/rules/*.data /opt/modsec/owasp/crs/rules/
# COPY common/modsec/owasp/rules/*.conf /opt/modsec/owasp/crs/rules/
# COPY common/modsec/owasp/crs-setup.conf /opt/modsec/owasp/crs/crs-setup.conf
# COPY common/modsec/owasp-master.conf /opt/modsec/owasp/crs/owasp-master.conf

COPY haproxy/01-haproxy-config.sh /01-haproxy-config.sh
RUN chmod +x /01-haproxy-config.sh
RUN /01-haproxy-config.sh

USER haproxy