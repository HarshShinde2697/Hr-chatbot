# ---------------------------------------------------
# HR Chatbot - Production Ready n8n Dockerfile
# ---------------------------------------------------

FROM n8nio/n8n:latest

# ---------------------------------------------------
# Production Environment Configuration
# ---------------------------------------------------

ENV NODE_ENV=production \
    N8N_HOST=chatbot-teams.trust.in \
    N8N_PORT=5678 \
    N8N_PROTOCOL=https \
    WEBHOOK_URL=https://chatbot-teams.trust.in/ \
    N8N_EDITOR_BASE_URL=https://chatbot-teams.trust.in/ \
    N8N_SECURE_COOKIE=true \
    GENERIC_TIMEZONE=Asia/Kolkata

# ---------------------------------------------------
# Prepare required directories
# ---------------------------------------------------

USER root

RUN mkdir -p /home/node/.n8n \
    && mkdir -p /home/node/.n8n-files \
    && mkdir -p /home/node/.n8n-files/documents \
    && chown -R node:node /home/node

# Switch back to node user (important for security)
USER node

# Expose internal n8n port
EXPOSE 5678

# ---------------------------------------------------
# Healthcheck (checks internal container health)
# ---------------------------------------------------

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:5678/healthz', (r) => { if (r.statusCode !== 200) process.exit(1) })"