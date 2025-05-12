# 📊 Reto #2 - Monitorización y Observabilidad en Kubernetes

## 👨‍💻 Integrantes
- Juan Diego Roa Porras
- Kevin Dannie Guzmán Duran 

## 🎯 Objetivo
El objetivo del reto era implementar de manera didáctica una solución completa de **monitorización y observabilidad** para una aplicación desplegada en **Kubernetes**, abordando los siguientes aspectos:

- ✅ Recolección de métricas del sistema (CPU, memoria, red)
- ✅ Recolección de métricas de la aplicación (latencia, errores, peticiones)
- ✅ Visualización de métricas en dashboards intuitivos y personalizables
- ✅ Configuración de alertas proactivas basadas en umbrales definidos
- ✅ Notificación ante posibles problemas antes de que impacten a los usuarios

## 🚀 Tecnologías Utilizadas

| Categoría              | Tecnologías |
|------------------------|-------------|
| Contenedores y Orquestación | ![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white) ![MicroK8s](https://img.shields.io/badge/MicroK8s-ffffff?style=for-the-badge&logo=kubernetes&logoColor=black) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) |
| Monitorización         | ![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white) ![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white) |
| Alertas                | ![Alertmanager](https://img.shields.io/badge/Alertmanager-FF6F00?style=for-the-badge&logo=prometheus&logoColor=white) ![Slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white) |
| Backend                | ![Spring Boot](https://img.shields.io/badge/Spring_Boot-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white) |
| Frontend               | ![Angular](https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white) ![NGINX](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white) |
| Base de datos          | ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white) |

## 🛠️ Guía de Despliegue en ![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-orange?logo=ubuntu)

### ✅ Verificar que Docker y Docker Compose estan instalados:
```bash
docker --version
docker compose version #Versiones nuevas
docker-compose version #Versiones más antiguas
```
**Si Docker y Docker Compose no están instalados, puedes seguir este tutorial:**  
- 🔗 [Guía de instalación en DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-es)  **O simplemente consultar a tu IA de confianza. 😉**
---
### ✅ Verificar si MicroK8s ya está instalado:
```bash
sudo microk8s status --wait-ready
```

### 📦 Instalar MicroK8s:
```bash
sudo snap install microk8s --classic
```

### 👤 Agregar tu `usuario` al grupo microk8s para evitar usar `sudo`:
```bash
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
```
> ⚠️ Importante: Después de ejecutar estos comandos, vuelve a iniciar sesión para que hagan efecto

### ⚙️ Habilitar complementos necesarios:
```bash
microk8s enable dns storage ingress
microk8s kubectl get pods -n ingress #Debería aparecer un pod
```

## 🛠️ Desplegar la aplicación: Universegames

### Clonar el Repositorio:
```bash
git clone https://github.com/JuanRoa785/Reto-2.git

#Verificar que se clonó correctamente:

#Deberá aparecer un directorio (Carpeta) llamado Reto-2
ls

#Acceder a la raiz del repo
cd Reto-2/
```

### 🗄️ Despliegue de la Base de Datos PostgreSQL
Para desplegar la base de datos, ejecuta los siguientes comandos desde la raíz del repositorio:
```bash
cd database/
microk8s kubectl apply -f postgres-config.yaml
microk8s kubectl apply -f postgres-secret.yaml
microk8s kubectl apply -f reto2-db-deployment.yaml
```
✅ Si el despliegue fue exitoso, podrás conectarte a la base de datos desde tu gestor favorito usando las siguientes credenciales:
| Parámetro         | Valor           |
| ----------------- | --------------- |
| **Puerto**        | `30543`         |
| **Base de datos** | `universegames` |
| **Usuario**       | `postgres`      |
| **Contraseña**    | `adminPostgres` |
<p align="center">
  <img src="https://github.com/user-attachments/assets/c9cf8584-574c-4bfe-892d-b4242b8d3a85" width=1000px>
</p>

### ☕ Despliegue del Backend en Springboot
Para desplegar el backend, ejecuta los siguientes comandos desde la raíz del repositorio:
```bash
cd backend/
microk8s kubectl apply -f reto2-back-deployment.yaml
```
✅ Una vez desplegado, puedes acceder a la documentación de la API a través de
```bash
http://localhost:30080/swagger-ui/index.html
```

###  🌐 Despliegue del Frontend (Angular + NGINX)
Para desplegar el frontend, ejecuta los siguientes comandos desde la raíz del repositorio:
```bash
cd frontend/
microk8s kubectl apply -f reto2-front-deployment.yaml
```
✅ Una vez desplegado, puedes acceder al aplicativo web desde tu navegador en:
```bash
http://localhost:30420
```
⚠️ Importante:
Para aprovechar al máximo las funcionalidades de la aplicación, se recomienda registrar un usuario administrador con los siguientes datos:
| Parámetro         | Valor            |
| ----------------- | ---------------  |
| **correo**        | `admin@admin.com`|
| **contraseña**    | `adminadmin`     |

Luego, modifica su rol directamente en la base de datos y asigna el valor `2` para convertirlo en administrador.
<p align="center">
  <img src="https://github.com/user-attachments/assets/11860ef6-e49f-4bd9-8b1b-552b904e1800" width=1000px>
</p>

###  🌐 Aplicación en funcionamiento
<p align="center">
  <img src="assetsReto2/SoftwareEnVivo.gif" alt="Software en Ejecución" width="950"/>
</p>


