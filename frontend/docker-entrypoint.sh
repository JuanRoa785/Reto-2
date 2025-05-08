#!/bin/sh

# Ruta donde estará el config.js en el contenedor
CONFIG_PATH=/usr/share/nginx/html/config.js

# Escribe las variables de entorno como propiedades en window
echo "window.API_URL = 'http://backend.local';" > $CONFIG_PATH

# Ejecuta el comando original (nginx)
exec "$@"