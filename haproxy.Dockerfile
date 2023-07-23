FROM haproxy:2.5

ARG PUBLIC_DOMAIN
ENV PUBLIC_DOMAIN=${PUBLIC_DOMAIN}

# Add directory for modsec installation
USER root
RUN mkdir --parents "/opt/owasp/crs/rules"

# Update and install basic packages
RUN apt-get update && apt-get -y install curl wget nano software-properties-common \
tzdata apt-utils git procps unzip make

# Install Modsecurity SPOA
# RUN git clone https://github.com/FireBurn/spoa-modsecurity.git /opt/spoa-modsecurity && \
# cd /opt/spoa-modsecurity && ./configure --prefix=$PWD/INSTALL --without-lua --enable-pcre-jit && \
# make -C standalone install && mkdir -p $PWD/INSTALL/include && cp standalone/*.h $PWD/INSTALL/include

# Copy OWASP rules and config for modsecurity
COPY common/owasp/rules/*.data /opt/owasp/crs/rules/
COPY common/owasp/rules/*.conf /opt/owasp/crs/rules/
COPY common/owasp/crs-setup.conf /opt/owasp/crs/crs-setup.conf
# COPY common/owasp-master.conf /opt/owasp/crs/owasp-master.conf

COPY haproxy/01-haproxy-config.sh /01-haproxy-config.sh
RUN chmod +x /01-haproxy-config.sh
RUN /01-haproxy-config.sh

USER haproxy