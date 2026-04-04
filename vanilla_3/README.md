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

This setup uses OpenTofu inside a Docker container to provision and manage infrastructure on Google Cloud Platform (GCP). The Docker Compose service encapsulates the OpenTofu environment, ensuring consistent execution across different machines.Infrastructure code is mounted from the local GCP/ directory into the container workspace, enabling seamless development and deployment. Secure authentication is handled via Google Cloud service account credentials, mounted into the container and referenced using environment variables. SSH keys are also mounted to enable secure access to provisioned virtual machines. OpenTofu in Docker Compose set up is easily to addapt to use third party CI/CD or create CI/CD on separate machine.

In GCP folder, there are modules and files in GCP root folder to easily manage if the module is getting bigger. Inside module, will define the resource based on our needs. Those only compute, loadbalancer, network and vm-template. There is startup.sh as well to configure the vm instance in the initial run. In GCP root folder, there is variables.tf file to input propmt during the creating resource execution.

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
