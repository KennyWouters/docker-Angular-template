# Build stage
FROM node:${NODE_VERSION:-20-alpine} as build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build -- --configuration=${BUILD_TARGET:-production}

# Production stage
FROM nginx:alpine

# Create or update nginx user
RUN if getent group ${NGINX_GROUP:-nginx}; then \
        echo "Group ${NGINX_GROUP:-nginx} already exists"; \
    else \
        addgroup -g ${NGINX_GID:-1001} ${NGINX_GROUP:-nginx}; \
    fi && \
    if getent passwd ${NGINX_USER:-nginx}; then \
        echo "User ${NGINX_USER:-nginx} already exists"; \
    else \
        adduser -D -u ${NGINX_UID:-1001} -G ${NGINX_GROUP:-nginx} ${NGINX_USER:-nginx}; \
    fi

# Copy built assets from build stage
COPY --from=build /app/dist/*/browser /usr/share/nginx/html

# Copy nginx configuration
COPY docker-front/production/nginx.conf /etc/nginx/conf.d/default.conf

# Set proper permissions
RUN chown -R ${NGINX_USER:-nginx}:${NGINX_GROUP:-nginx} /usr/share/nginx/html && \
    chown -R ${NGINX_USER:-nginx}:${NGINX_GROUP:-nginx} /var/cache/nginx && \
    chown -R ${NGINX_USER:-nginx}:${NGINX_GROUP:-nginx} /var/log/nginx && \
    chown -R ${NGINX_USER:-nginx}:${NGINX_GROUP:-nginx} /etc/nginx/conf.d && \
    touch /var/run/nginx.pid && \
    chown -R ${NGINX_USER:-nginx}:${NGINX_GROUP:-nginx} /var/run/nginx.pid

# Switch to non-root user
USER ${NGINX_USER:-nginx}

# Expose port
EXPOSE ${NGINX_PORT:-80}

# Start nginx
CMD ["nginx", "-g", "daemon off;"] 