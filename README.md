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

##  Task 1: Chocholate_2

**Description:**  
Simple Next.js app in Docker

- Dockerfile uses multistage to ...
- The apps expose port 3000. The dockerfile create container image only with necessary files and builded package.
- healthchecks is added in image container to ensure the service healthy
- add nginx as a proxy to forward port 80 and make it more secure.

**How to Run:**  
Ensure you have docker running on your laptop!!

Locate your working dir is in chocholate_2 folder then open the terminal, and execute

```bash
docker compose up
```

then, if want to kill the service use :

```bash
docker compose down
```

##  Task 3: Vanilla_3

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



🚀 Vanilla_3: GCP Web Server Provisioning
This project automates the deployment of two distinct web server setups on Google Cloud Platform:

High Availability: An Instance Group seated behind an HTTP Load Balancer.

Standalone: A single Compute Engine VM for simple hosting.

📋 Prerequisites

Docker & Docker Compose: Must be installed and running on your machine.

GCP Account: An active project with billing enabled.

Your Public IP: You will need this to configure the SSH firewall rule during the apply phase.

🔐 Step 1: Service Account Setup (GCP)

Before running the code, you must create a Service Account to allow OpenTofu to manage resources.

Go to IAM & Admin > Service Accounts in the GCP Console.

Click Create Service Account.

Assign the following roles (for least privilege, use specific roles, but for this task, these are common):

Compute Admin

Network Admin

Once created, go to the Keys tab of the service account.

Click Add Key > Create New Key and select JSON.

Save this file inside your vanilla_3 folder and rename it to credentials.json (or ensure your .tf files point to the correct filename).

🛠️ Step 2: Deployment

Open your terminal in the vanilla_3 directory and follow these steps:

1. Verify Installation

Ensure the Docker container and OpenTofu are ready.

Bash
docker-compose run --rm tofu version
2. Initialize OpenTofu

Download the necessary GCP providers and initialize the backend.

Bash
docker-compose run --rm tofu init
3. Apply Configuration

Deploy the infrastructure. Note: You will be prompted to input your Public IP for the SSH firewall rule.

Bash
docker-compose run --rm tofu apply
[!IMPORTANT]

When prompted for your IP, provide it in CIDR notation (e.g., 203.0.113.5/32).

🖥️ Step 3: Accessing the Servers

Once the process finishes, the terminal will output the following IP addresses. Copy and paste them into your browser to verify:

Load Balancer IP: http://<LB_IP_ADDRESS>

Standalone VM IP: http://<VM_IP_ADDRESS>

🗑️ Step 4: Cleanup

To avoid incurring unnecessary costs on your GCP account, destroy the resources when you are finished:

Bash
docker-compose run --rm tofu destroy