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
- **Curl** – 5 HTTP requests to check response  
- **Disk Usage** – checks available disk space  

**How to Run:**  
From the terminal, provide the hostname and port:

```bash
bash health_check.sh <hostname> <port>
```

If it doesnt run, change the file to executeable by using : 

```bash
chmod +x health_check.sh
```

# 🍫 Task 2: Chocolate_2

Chocolate_2 is a simple **Next.js** application running in **Docker**.

---

## 🌟 Description

- The **Dockerfile** uses a **multi-stage build** to produce a lightweight production image containing only the necessary files and the built app package.  
- The app exposes **port 3000** inside the container.  
- A **health check** is added to the container image to ensure the service is healthy and running.  
- **Nginx** is configured as a reverse proxy to forward **port 80**, improving security and production readiness.

---

## 🚀 How It Works

1. **Build Stage:**  
   - Installs dependencies  
   - Builds the Next.js application  

2. **Production Stage:**  
   - Copies only the necessary build artifacts  
   - Sets up Nginx as a reverse proxy  
   - Exposes port 80 for external access  

3. **Health Check:**  
   - Periodically checks the app inside the container to ensure it responds correctly  

---

## ⚡ Quick Start

```bash
# Build the Docker image
docker build -t chocolate_2 .

# Run the container
docker run -p 80:80 chocolate_2

# Access in browser
http://localhost
```

##  🍪 Task 3: Vanilla_3

**Description:**  
Provision a simple web server using OpenTofu to GCP

- Opentofu is installed on docker.
- There are two provision type. 1. use instance group which is the server behin the http LoadBalancer and 2. use standalone instance
- The firewall IP SSH is forced to only ourself. So during the build process, user have to input the right public IP. (If user have VPN connection it will be better config later)
- Provide both outputs. LB IP and the standalone vm IP Public (access it using browser)

**How to Run:**  
Ensure you have docker running on your laptop!!

Locate your working dir is in vanilla_3 folder then open the terminal, and execute

To check :
```bash
docker-compose run --rm tofu version
```

then, if OK continue to next step :

```bash
docker-compose run --rm tofu init
docker-compose run --rm tofu apply
```

If user want to destroy, use

```bash
docker-compose run --rm tofu destroy
```

Ensure user read and fill the prompt correctly!!

But, for this one, DONT FORGET TO CREATE SERVICE ACCOUNT IN GCP by follow this bellow instruction.



🍪 Task 3: Vanilla_3</summary>

### Provisioning Options

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

## Prerequisites
- [Docker](https://www.docker.com/) installed and running  
- **GCP Service Account** with required permissions  
  - Download JSON key for OpenTofu authentication  

---

## Setup Instructions

### 1️⃣ Create GCP Service Account
Follow GCP instructions to create a service account and download its JSON key. This will be used by OpenTofu to authenticate.

---

### 2️⃣ Run OpenTofu in Docker
Open a terminal in the `vanilla_3` folder:

**Check OpenTofu version**
```bash
docker-compose run --rm tofu version
```
Initialize OpenTofu
```bash
docker-compose run --rm tofu init
```
Apply configuration
```bash
docker-compose run --rm tofu apply
```
⚠️ Make sure to fill in the prompts correctly, especially your public IP for SSH access.
3️⃣ Destroy Resources

```bash
docker-compose run --rm tofu destroy
```
Outputs

Resource Type	Access Method
Load Balancer IP	Open in browser (instance group)
Standalone VM IP	Open in browser (direct VM access)
Tips
Ensure Docker is running before executing commands
Double-check your public IP to avoid SSH lockout
VPN can simplify configuration if your IP changes
</details> ```
✅ Just copy all of that into README.md in VS Code — it’s ready to render beautifully on GitHub with collapsible task details, tables, badges, and clear instructions.
If you want, I can make a version with colorful terminal command boxes and Docker/OpenTofu icons so it looks super “GitHub professional” with minimal effort.

Do you want me to do that next?
