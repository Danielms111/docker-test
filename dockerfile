# Etapa 1: Construcción
FROM node:18 AS build

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

# Etapa 2: Servir con Nginx
FROM nginx:alpine

# Copiar la compilación de React al directorio de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto 80 para servir la aplicación
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
