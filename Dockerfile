FROM coturn/coturn:latest

# Switch to root to perform setup and run the server
USER root

# Ensure turnserver is executable
RUN chmod +x /usr/bin/turnserver

# Create necessary directories with correct permissions
RUN mkdir -p /etc/coturn/ssl && \
    chmod -R 755 /etc/coturn

# Copy configuration
COPY turnserver.conf /etc/coturn/turnserver.conf

# Create a health check script
COPY health.sh /usr/local/bin/health.sh
RUN chmod +x /usr/local/bin/health.sh

# Copy and set up the entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Expose ports
EXPOSE 3478 3478/udp 5349 5349/udp
EXPOSE 49152-65535/udp

# Use the entrypoint script
ENTRYPOINT ["/docker-entrypoint.sh"]
