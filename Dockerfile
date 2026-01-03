FROM coturn/coturn:latest

# Create config and SSL directories
RUN mkdir -p /etc/coturn/ssl

# Copy configuration
COPY turnserver.conf /etc/coturn/turnserver.conf

# Create a health check script
COPY health.sh /usr/local/bin/health.sh
RUN chmod +x /usr/local/bin/health.sh

# Create a script to handle SSL certificates
RUN echo '#!/bin/sh\n\
# If SSL certificates are provided, use them\nif [ -f "/etc/coturn/ssl/cert.pem" ] && [ -f "/etc/coturn/ssl/key.pem" ]; then\n    echo "Using provided SSL certificates"\nelse\n    echo "No SSL certificates found, disabling TLS"\n    # Comment out TLS related options in the config\n    sed -i 's/^tls-listening-port=/# tls-listening-port=/g' /etc/coturn/turnserver.conf\n    sed -i 's/^cert=/# cert=/g' /etc/coturn/turnserver.conf\n    sed -i 's/^pkey=/# pkey=/g' /etc/coturn/turnserver.conf\nfi\n\n# Start the TURN server\nexec turnserver -c /etc/coturn/turnserver.conf' > /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh

# Expose ports
EXPOSE 3478 3478/udp 5349 5349/udp
EXPOSE 49152-65535/udp

# Use the entrypoint script
ENTRYPOINT ["/docker-entrypoint.sh"]
