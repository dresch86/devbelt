#!/bin/bash
set -e

ESCAPED_PUBLIC_DOMAIN=${PUBLIC_DOMAIN//\./\\.}

cat > /usr/local/etc/haproxy/haproxy.cfg <<EOF
global
    daemon
    maxconn 4000
    user haproxy
    group haproxy

defaults
    mode                    http
    log                     127.0.0.1 local0
    option                  httplog
    option                  forwardfor
    option                  dontlognull
    timeout client          60s
    timeout server          60s
    timeout connect         60s

frontend portal
    bind *:80
    bind *:443 ssl crt /etc/ssl/certs/${PUBLIC_DOMAIN}/fullchain.pem
    http-request set-header X-Forwarded-Proto https if { ssl_fc }
    http-request set-header X-Forwarded-Proto http if !{ ssl_fc }
    http-request redirect scheme https code 301 unless { ssl_fc }
    http-response set-header Strict-Transport-Security "max-age=16000000; includeSubDomains; preload;"
    acl git_acl hdr(host) -m reg -i ^git\.${ESCAPED_PUBLIC_DOMAIN}\$
    use_backend git.${PUBLIC_DOMAIN} if git_acl
    acl projects_acl hdr(host) -m reg -i ^projects\.${ESCAPED_PUBLIC_DOMAIN}\$
    use_backend projects.${PUBLIC_DOMAIN} if projects_acl

backend git.${PUBLIC_DOMAIN}
    balance roundrobin
    server git gitea:3000 check

backend projects.${PUBLIC_DOMAIN}
    balance roundrobin
    server projects leantime:80 check
EOF