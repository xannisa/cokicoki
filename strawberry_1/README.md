## 🍓 Task 1: Strawberry_1

**Script:** `health_check.sh`  

**Description:**  
Performs a basic server health check, including:

- **Ping** – 5 attempts to check connectivity  
- **Curl** – 5 HTTP requests to check response  
- **Disk Usage** – checks available disk space  

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