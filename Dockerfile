# Force rebuild v4 - 2025-01-14
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
ENV NODE_ENV=production
RUN npm run build
RUN npm prune --omit=dev
EXPOSE 9000
CMD ["npm", "run", "start"]

