#!/bin/sh

# Ensure permissions are correct
chmod -R 755 /etc/coturn

# If SSL certificates are provided, use them
if [ -f "/etc/coturn/ssl/cert.pem" ] && [ -f "/etc/coturn/ssl/key.pem" ]; then
    echo "Using provided SSL certificates"
    chmod 644 /etc/coturn/ssl/cert.pem
    chmod 600 /etc/coturn/ssl/key.pem
else
    echo "No SSL certificates found, disabling TLS"
    # Comment out TLS related options in the config
    sed -i 's/^tls-listening-port=/# tls-listening-port=/g' /etc/coturn/turnserver.conf
    sed -i 's/^cert=/# cert=/g' /etc/coturn/turnserver.conf
    sed -i 's/^pkey=/# pkey=/g' /etc/coturn/turnserver.conf
fi

# Execute the TURN server
exec turnserver -c /etc/coturn/turnserver.conf
