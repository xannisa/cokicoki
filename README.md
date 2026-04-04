# 🍪 CokiCoki

CokiCoki is a fun project featuring **3 delicious flavours**, each with a task and associated scripts.  

This README explains each task, how to run the scripts, and provides usage examples.

---

## 🌟 Flavours Overview

| Flavour         | Task          | Description                                   | Status          |
|-----------------|---------------|-----------------------------------------------|----------------|
| 🍓 Strawberry_1 | Task 1        | Basic server health check (ping, curl, disk) | Ready           |
| 🍫 Chocolate_2  | Task 2        | Simple Next.js app in Docker     | Ready   |
| 🍪 Vanilla_3    | Task 3        | Provision a simple web server using OpenTofu        | Ready         |


---

## 🍓 Task 1: Strawberry_1

**Script:** `health_check.sh`  

**Description:**  
Performs a basic server health check, including:

- **Ping** – 5 attempts to check connectivity  
- **Curl** – HTTP/S request to check web response. Only result for 2xx and 3xx is classified for healthy. 
- **Disk Usage** – Checks available disk space  

**How to Run:**  
From the terminal in the strawberry_1 directory, run the script using this command :

```bash
./health_check.sh <server_ip_or_hostname> <port>
```

Example :
```bash
./health_check.sh localhost 8080
```

If it doesnt run, change the file to executeable by using : 

```bash
chmod +x health_check.sh
```

It will produce health_checks.log file in the same directory. 

## 🍫 Task 2: Chocholate_2

Chocholate_2 is a simple **Next.js** application running in **Docker**.

---

### 🌟 Description
🌟 Description

1. The Dockerfile uses a multi-stage build to create a lightweight, production-ready image containing only the compiled Next.js application and required dependencies.
2. The application runs internally on port 3000, but is not exposed publicly.
3. A Docker healthcheck is defined to continuously verify that the application is responding correctly.
4. The application is deployed using Docker Swarm, enabling replication, load balancing, and self-healing.
5. Nginx is used as a reverse proxy, exposing port 80 as the single public entry point and forwarding requests to the internal next-app-js service.


---

### 🚀 How It Works

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

### 📁 Project Structure

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

### 🚀 Getting Started

#### Prerequisites
- [Docker](https://www.docker.com/) installed and running.

Locate user to chocholate_2 folder.

#### 1. Build the Docker Image

```bash
docker build -t next-app-js:latest .
```

#### 2. Start Docker Swarn

```bash
docker stack deploy -c docker-compose.yaml <name>
```

Replace <name> with any-name.
Wait for sometime until all replica is ready.

#### 3. Debugging 

For check, use this command :
```bash
docker service ls | grep <name>
```

After all replicas ready. Then access localhost through browser or use healthcheck.sh on strawberry_1.

#### 4. Remove and Kill Docker

To remove the running stack, use this command :

```bash
docker stack rm <name>
```


## 🍪 Task 3: Vanilla_3

### Provisioning Options (not an option, it deploy both :v)

| Option             | Description                                     |
|-------------------|-------------------------------------------------|
| **Instance Group** | Server behind an HTTP Load Balancer            |
| **Standalone VM**  | Single VM instance accessible via public IP    |

**Notes:**  
- SSH access is restricted to your **public IP**; enter it correctly when prompted  
- Using a VPN is recommended if your IP changes frequently  
- After provisioning, you will receive:  
  - **Load Balancer IP** (instance group)  
  - **Standalone VM Public IP**

---

### 🌟 Description

This setup uses OpenTofu inside a Docker container to provision and manage infrastructure on Google Cloud Platform (GCP). The Docker Compose service encapsulates the OpenTofu environment, ensuring consistent execution across different machines.Infrastructure code is mounted from the local GCP/ directory into the container workspace, enabling seamless development and deployment. Secure authentication is handled via Google Cloud service account credentials, mounted into the container and referenced using environment variables. SSH keys are also mounted to enable secure access to provisioned virtual machines.

In GCP folder, there are modules and files in GCP root folder. Inside module, will define the resource based on our needs. Those only compute, loadbalancer, network and vm-template. There is startup.sh as well to configure the vm instance in the initial run. In GCP root folder, there is variables.tf file to input propmt during the creating resource execution.

---

### 📁 Project Structure

.
├── main.tf
├── variables.tf
├── startup.sh
└── modules/
    ├── network/
    │   ├── main.tf
    │   └── variables.tf
    ├── vm-template/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── loadbalancer/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── loadbalancer/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf

---

### Prerequisites
- [Docker](https://www.docker.com/) installed and running  
- **GCP Service Account** with required permissions  
  - Download JSON key for OpenTofu authentication  

---

### Setup Instructions

This will be used by OpenTofu to authenticate.

#### 1 Create GCP Service Account
Follow GCP instructions (https://docs.cloud.google.com/iam/docs/service-accounts-create) to create a service account.

**Important** 
Set the Role only : COMPUTE INSTANCE ADMIN (V1), COMPUTE NETWORK ADMIN, COMPUTE SECURITY ADMIN. To limit access and ensure security matters.

After create, then download the key and locate to vanilla_3/.env/opentofu-cred.json.

#### 2 Enable API Compute Engine
Enable API for compute engine (https://docs.cloud.google.com/endpoints/docs/openapi/enable-api). This feature is not free tier, so becarefull.

#### 3 Setup Project_id from GCP into variables.tf inside GCP folder.

copy user project id into variables.tf inside GCP folder.

```bash
variable "project_id" {
  type = string
  default = "REPLACE WITH USER PROJECT ID"
}
```

---
### 🚀 Getting Started to Run OpenTofu in Docker

Locate user in the `vanilla_3` folder:

**Check OpenTofu version**
```bash
docker-compose run --rm tofu version
```
**Initialize OpenTofu**
```bash
docker-compose run --rm tofu init
```
**Apply configuration**
```bash
docker-compose run --rm tofu apply
```
⚠️ Make sure to fill in the prompts correctly, especially your public IP for SSH access.

**Destroy Resources**

```bash
docker-compose run --rm tofu destroy
```
