# Stage 1: Builder
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies (including dev)
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS production

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy built files from builder
COPY --from=builder /app/.medusa ./.medusa
COPY --from=builder /app/dist ./dist

# Copy static files
COPY --from=builder /app/static ./static

# Copy config files
COPY medusa-config.ts ./
COPY tsconfig.json ./

# Expose Medusa port
EXPOSE 9000

# Start Medusa
CMD ["npm", "run", "start"]
