# 🍪 CokiCoki

CokiCoki is a fun project featuring **3 delicious flavours**, each with a task and associated scripts.  

This README explains each task, how to run the scripts, and provides usage examples.

---

## 🌟 Flavours Overview

| Flavour         | Task          | Description                                   | Status          |
|-----------------|---------------|-----------------------------------------------|----------------|
| 🍓 Strawberry_1 | Task 1        | Basic server health check (ping, curl, disk) | Ready           |
| 🍫 Chocolate_2  | Task 2        | [Add short description for Chocolate_2]      | In Progress     |
| 🍪 Vanilla_3    | Task 3        | [Add short description for Vanilla_3]        | Pending         |

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