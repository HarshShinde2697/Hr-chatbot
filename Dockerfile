# Use official n8n base image
FROM n8nio/n8n:latest

# Switch to root to prepare folders
USER root

# Ensure required directories exist
RUN mkdir -p /home/node/.n8n \
    && mkdir -p /home/node/.n8n-files/documents \
    && chown -R node:node /home/node

# Switch back to node user (important)
USER node

# Expose n8n default port
EXPOSE 5678