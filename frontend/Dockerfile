# Etapa 1: Build de la aplicación Angular
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .
RUN npm run build --prod

# Etapa 2: Imagen final para servir con http-server
FROM node:20-slim

WORKDIR /app

RUN npm install -g http-server

# Copia los archivos compilados de Angular desde la etapa anterior
COPY --from=build /app/dist/ /app/dist/

# Puerto donde se servirá la app (por defecto http-server usa el 8080)
EXPOSE 8080

# Comando para servir la app desde la carpeta de distribución
CMD ["http-server", "dist", "-p", "8080", "-c-1"]
