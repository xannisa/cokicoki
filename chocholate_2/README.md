# 🍫 Task 2: Chocholate_2

Chocholate_2 is a simple **Next.js** application running in **Docker**.

---

## 🌟 Description
🌟 Description

1. The Dockerfile uses a multi-stage build to create a lightweight, production-ready image containing only the compiled Next.js application and required dependencies.
2. The application runs internally on port 3000, but is not exposed publicly.
3. A Docker healthcheck is defined to continuously verify that the application is responding correctly.
4. The application is deployed using Docker Swarm, enabling replication, load balancing, and self-healing.
5. Nginx is used as a reverse proxy, exposing port 80 as the single public entry point and forwarding requests to the internal next-app-js service.


---

## 🚀 How It Works

1. Build Stage (Dockerfile)
Installs dependencies using npm install. Builds the next-app-js app using npm run build. Then, uses multi-stage build to reduce final image size.
2. Production Runtime
The final container:
Contains only the built app and necessary files
Runs in production mode
Listens on port 3000 internally
A healthcheck periodically verifies the app is responding
3. Docker Swarm Orchestration
The service is deployed with:
Multiple replicas (e.g., 3)
Automatic load balancing across replicas
Self-healing: unhealthy containers are replaced automatically
Swarm maintains a desired state, ensuring the defined number of replicas is always running
4. Internal Networking
Services communicate over a Swarm overlay network
The Next.js service is reachable internally via:
http://next-app-js:3000
It is not exposed to the outside world
5. Nginx Reverse Proxy
Nginx exposes port 80 to the public
Incoming requests are forwarded to the Next.js service:
nginx → next-app-js:3000
This provides:
A single entry point
Improved security
Flexibility for adding HTTPS, caching, or routing rules
6. Health Monitoring & Self-Healing
The healthcheck runs periodically inside each container
If a container fails:
Swarm marks it as unhealthy
Stops it
Replaces it with a new one automatically


---

### 🧠 Architecture Summary

Client → Nginx (port 80)
              ↓
        next-app-js (port 3000, internal)
              ↓
     Multiple replicas (Swarm)

This architecture improves security, scalability, and reliability by isolating the application from direct external access.

---

## 📁 Project Structure

.
├── app/
│   ├── package.json
│   └── pages/
│       └── index.js
├── nginx/
│   └── nginx.conf
├── Dockerfile
├── docker-compose.yml
└── README.md

---

## 🚀 Getting Started

## Prerequisites
- [Docker](https://www.docker.com/) installed and running.

Locate user to chocholate_2 folder.

### 1. Build the Docker Image

```bash
docker build -t next-app-js:latest .
```

### 2. Start Docker Swarn

```bash
docker stack deploy -c docker-compose.yaml <name>
```

Replace <name> with any-name.
Wait for sometime until all replica is ready.
For check, use this command :
```bash
docker service ls | grep <name>
```

After all replicas ready. Then access localhost through browser or use healthcheck.sh on strawberry_1.

To remove the running stack, use this command :

```bash
docker stack rm <name>
```
