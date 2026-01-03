FROM coturn/coturn:latest

# Create config directory
RUN mkdir -p /etc/coturn

# Copy configuration
COPY turnserver.conf /etc/coturn/turnserver.conf

# Create SSL directory
RUN mkdir -p /etc/coturn/ssl

# Copy SSL certificates (if available)
COPY ssl/ /etc/coturn/ssl/

# Expose ports
EXPOSE 3478 3478/udp 5349 5349/udp
EXPOSE 49152-65535/udp

CMD ["turnserver", "-c", "/etc/coturn/turnserver.conf"]
