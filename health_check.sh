#!/bin/bash

LOG_FILE="health_check.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Function to log messages
log() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <server_ip_or_hostname> [port]"
    exit 1
fi

SERVER="$1"
PORT="${2:-80}"

log "Starting health check for $SERVER on port $PORT"

# 1. Ping Test
ping -c 3 "$SERVER" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    log "Ping Test: Server unreachable"
    exit 2
else
    log "Ping Test: Server reachable"
fi

# 2. HTTP/S Check
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "http://$SERVER:$PORT")

if [[ "$HTTP_STATUS" =~ ^2|3 ]]; then
    log "HTTP Check on port $PORT: UP (Status: $HTTP_STATUS)"
else
    log "HTTP Check on port $PORT: DOWN (Status: $HTTP_STATUS)"
fi

# 3. Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5 " used (" $3 "/" $2 ")"}')
log "Disk Usage (/): $DISK_USAGE"

log "Health check completed"
