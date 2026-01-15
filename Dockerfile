FROM node:20-alpine
# Force rebuild 2026-01-15
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
ENV NODE_ENV=production
EXPOSE 9000
CMD ["npm", "run", "start"]
