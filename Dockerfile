FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
# Force rebuild
ARG CACHEBUST=1
RUN npm run build
ENV NODE_ENV=production
EXPOSE 9000
CMD ["npm", "run", "start"]
