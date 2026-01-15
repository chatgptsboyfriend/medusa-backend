# Stable Medusa v2 - admin fix
FROM node:20-alpine
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
ENV NODE_ENV=production

# Build admin + API explicitement
RUN npm run build
RUN npx medusa build

EXPOSE 9000
CMD ["npm", "run", "start"]
