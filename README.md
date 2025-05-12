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

---

### 📦 Instalar Helm:
```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```

### 📦 Instalar kube-state-metrics:
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
microk8s helm install kube-state-metrics prometheus-community/kube-state-metrics --namespace monitoring --create-namespace
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

---

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

---

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

---

###  🌐 Despliegue del Frontend (Angular + NGINX)
Antes de desplegar el frontend, asegúrate de tener correctamente configurado el acceso al backend mediante Ingress.

🔍 1. Obtener la IP del nodo donde corre Ingress

Ejecuta el siguiente comando para obtener la IP del nodo:
```bash
microk8s kubectl describe pods -n ingress
```
Esto generará una salida similar a:
<p align="center">
  <img src="https://github.com/user-attachments/assets/babf166a-5d3f-4b56-bc18-793be8dfb613" width=900px>
</p>

🧾 2. Configurar alias local en `/etc/hosts`

Edita el archivo de hosts en tu máquina local:

```bash
sudo nano /etc/hosts
```

Agrega una línea como la siguiente, reemplazando `<IP NODO>` por la IP obtenida anteriormente:
```bash
<IP NODO> backend.local
```
🚀 3. Desplegar el frontend

Desde la raíz del repositorio, ejecuta:
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

---

###  🌐 Aplicación en funcionamiento
<p align="center">
  <img src="assets/softwareEnVivo.gif" alt="Software en Ejecución" width="950"/>
</p>

---

## 🔍📊 Despliegue de herramientas de monitoreo
Ubícate primero en el directorio monitoring:
```bash
cd monitoring/
```

### 🧠 Namespace y configuración de Prometheus
1. Crear el namespace que contendrá todos los pods de Prometheus, Alertmanager y Grafana:
   ```bash
   microk8s kubectl apply -f namespace.yaml
   ```
2. Configurar Prometheus (alertas y scrapping automático):
   ```bash
   microk8s kubectl apply -f prometheus-config.yaml
   ```
3. Desplegar Prometheus:
   ```bash
   microk8s kubectl apply -f prometheus-deployment.yaml
   ```
✅ Podrás acceder a Prometheus desde tu navegador en:
```bash
http://localhost:30000/query
```

<p align="center">
  <img src="https://github.com/user-attachments/assets/24281c2c-badb-479d-abf2-4878fe81abe3" width="950"/>
</p>

---

### 🚨 Configuración y despliegue de Alertmanager
1. Editar el archivo de configuración para agregar tu Webhook de Slack:
   ```bash
   nano alertmanager-config.yaml
   ```
   - Agrega tu URL de Slack en el campo:
       ```bash
       slack_api_url: 'https://hooks.slack.com/services/XXX/YYY/ZZZ'
       ```
   - Cambia los nombres de los canales que recibirán las alertas. (Deben existir previamente en Slack.)
2. Aplicar la configuración y desplegar Alertmanager:
   ```bash
   microk8s kubectl apply -f alertmanager-config.yaml
   microk8s kubectl apply -f alertmanager-deployment.yaml
   ```
Las alertas en `slack` se verán de la siguiente manera:
<p align="center">
  <img src="https://github.com/user-attachments/assets/c2de0bcf-8173-4529-8788-5c1f98c9d179" width="950"/>
</p>

---

### 📈 Configuración y despliegue de Grafana
1. Aplicar todos los archivos de configuración y dashboards:
   ```bash
   microk8s kubectl apply -f grafana-config.yaml
   microk8s kubectl apply -f grafana-dashboards-definitions.yaml
   microk8s kubectl apply -f grafana-dashboards-sources.yaml
   microk8s kubectl apply -f grafana-datasources.yaml
   ```
2. Desplegar Grafana y exponer el servicio:
   ```bash
   microk8s kubectl apply -f grafana-deployment.yaml
   microk8s kubectl apply -f grafana-service.yaml
   ```
✅ Podrás acceder a Grafana desde tu navegador en:
```bash
http://localhost:30300/
```
<p align="center">
  <img src="https://github.com/user-attachments/assets/258ce8f4-4e18-4960-9de1-24434d48d41e" width="950"/>
</p>

---

## 📚 Bibliografía y Recursos Complementarios
A continuación se listan las principales fuentes utilizadas como apoyo para el desarrollo e implementación de esta solución:
- 🔗 **Código fuente del proyecto UniverseGames**  
  [https://github.com/pimientoyolo125/universeGame.git](https://github.com/pimientoyolo125/universeGame.git)

- 🎥 **Video guía de Prometheus - Curso DevOps en Kubernetes (Español)**  
  [https://www.youtube.com/watch?v=yvUQMdgbz_c&list=PLqRCtm0kbeHA5M_E_Anwu-vh4NWlgrOY_&index=8](https://www.youtube.com/watch?v=yvUQMdgbz_c&list=PLqRCtm0kbeHA5M_E_Anwu-vh4NWlgrOY_&index=8)

- 🎥 **Video guía de Grafana - Dashboard de métricas personalizadas**  
  [https://www.youtube.com/watch?v=_mJPvzMStPI](https://www.youtube.com/watch?v=_mJPvzMStPI)

- 🧰 **Repositorio oficial kube-prometheus**  
  [https://github.com/prometheus-operator/kube-prometheus](https://github.com/prometheus-operator/kube-prometheus)

- 📣 **Guía para notificaciones de Alertmanager a Slack**  
  [https://youtu.be/luEUTR4cYl4](https://youtu.be/luEUTR4cYl4)
