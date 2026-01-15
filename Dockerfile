FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# Build AVANT de passer en production
RUN npm run build

# Supprime les devDeps après le build
RUN npm prune --production

ENV NODE_ENV=production
EXPOSE 9000
CMD ["npm", "run", "start"]
