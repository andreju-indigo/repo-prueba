
FROM node:24.21.0-slim AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

# Etapa 2: servir con Nginx
FROM nginx:1.30-alpine


COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist/control-gastos-frontend/browser /usr/share/nginx/html

EXPOSE 80