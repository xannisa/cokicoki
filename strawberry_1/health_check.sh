#!/bin/bash

LOG_FILE="health_check.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Function to log messages
log() {
    if [ "$1" = "-p" ]; then
        shift
        echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
    else
        echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
        echo "$1"
    fi
}

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <server_ip_or_hostname> [port]"
    exit 1
fi

SERVER="$1"
PORT="${2:-80}"

if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
    echo "Error: Port must be a number"
    exit 1
fi

log -p "===== Starting health check for $SERVER on port $PORT ====="

# Ping Check 5 times (normal counter) if all get success then log Server reachable
if ping -c 5 "$SERVER" &> /dev/null
then
  log "Success : Server reachable."
else
  log "Server unreachable."
fi

# 2. HTTP/S Check only 2xx and 3xx that classify as healthy. 5 times checking.

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "http://$SERVER:$PORT")

HTTPS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "https://$SERVER:$PORT")

if [[ "$HTTP_STATUS || $HTTPS_STATUS" =~ ^2|3 ]]; then
    log "Web service on port $PORT is UP."
else
    log "Web service on port $PORT is DOWN."
fi

# 3. Disk Usage

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5 " used (" $3 "/" $2 ")"}')
log "Disk Usage (/): $DISK_USAGE"

echo "Results logged to health_check.log"
