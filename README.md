# TURN Server on Render

This repository contains the configuration and deployment files for setting up a TURN server using Coturn on Render.

## Prerequisites

1. A Render.com account
2. Docker installed locally (for testing)
3. Git installed

## Configuration

### 1. Update Configuration

1. Open `turnserver.conf` and update the following:
   - Change `realm` to your domain
   - Update the `user` entries with your preferred usernames and passwords
   - For production, uncomment and configure the SSL certificate paths
   - Update the `static-auth-secret` with a strong secret

2. (Optional) Add SSL certificates:
   - Place your SSL certificate and key in the `ssl/` directory
   - Update the `cert` and `pkey` paths in `turnserver.conf`

## Local Testing

1. Build the Docker image:
   ```bash
   docker build -t turn-server .
   ```

2. Run the container:
   ```bash
   docker run -p 3478:3478 -p 3478:3478/udp -p 5349:5349 -p 5349:5349/udp -e EXTERNAL_IP=your_local_ip turn-server
   ```

## Deployment to Render

1. Push this repository to GitHub
2. Log in to your Render.com dashboard
3. Click "New" and select "Web Service"
4. Connect your GitHub repository
5. Configure the service:
   - Name: `turn-server`
   - Region: Choose the closest to your users
   - Branch: `main` (or your preferred branch)
   - Root Directory: (leave empty if files are in the root)
   - Build Command: (leave empty)
   - Start Command: (leave empty, uses Dockerfile)
6. Click "Create Web Service"

## Usage

Your TURN server will be available at:
- STUN/TURN: `turn:your-render-url.onrender.com:3478`
- TURN over TLS: `turns:your-render-url.onrender.com:5349`

## Security Notes

1. Always use strong, unique credentials
2. Enable TLS in production
3. Regularly rotate credentials
4. Monitor your server's usage and logs

## Troubleshooting

- Check the logs in the Render dashboard
- Ensure all required ports are open and forwarded correctly
- Verify your TURN server is reachable using online testing tools
