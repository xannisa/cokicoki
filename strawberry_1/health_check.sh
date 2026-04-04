#!/bin/bash

LOG_FILE="health_check.log"

# ---------- Logging ----------
log() {
    [ "$#" -eq 0 ] && return
    [ "$1" = "-p" ] && p=false && shift || p=true

    # Create different color for log status (only in console)
    case "$1" in
        SUCCESS) c='\033[0;32m'; lvl="$1"; shift ;;
        ERROR)   c='\033[0;31m'; lvl="$1"; shift ;;
        *)       c='\033[0m'; lvl="" ;;
    esac

    msg="$*"

    echo "[$(date '+%F %T')] ${lvl:+[$lvl] }$msg" >> "$LOG_FILE"
    $p && echo -e "${c}${lvl:+[$lvl] }$msg\033[0m"
}

# ---------- Validation ----------
# Ensure the script call is in the proper condition. And the port is only number format
validate_input() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <server_ip_or_hostname> [port]"
        exit 1
    fi

    if ! [[ "$2" =~ ^[0-9]+$ ]]; then
        echo "Error: Port must be a number"
        exit 1
    fi
}

# ---------- Ping Check ----------
# Ping checks 5 attempts. Why? cz its the minimum standard. Need all attempts success then classify as server is reachable.
check_ping() {
    if ping -c 5 "$SERVER" &> /dev/null; then
        log SUCCESS "Server is reachable."
    else
        log ERROR "Server is unreachable."
    fi
}

# ---------- HTTP/HTTPS Check ----------
# Curl checks result for 2xx and 3xx is classified for healthy. 
check_http() {
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "http://$SERVER:$PORT")
    HTTPS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "https://$SERVER:$PORT")

    if [[ "$HTTP_STATUS" =~ ^[23] || "$HTTPS_STATUS" =~ ^[23] ]]; then
        log SUCCESS "Web service on port $PORT is UP."
    else
        log ERROR "Web service on port $PORT is DOWN."
    fi
}

# ---------- Disk Check ----------
# Disk space available on current server (not the others server or IP)
check_disk() {
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5 " used (" $3 "/" $2 ")"}')
    log "Disk Usage (/): $DISK_USAGE"
}

# ---------- Main ----------
# Call the all functions
SERVER="$1"
PORT="${2:-80}"

validate_input "$SERVER" "$PORT"

log -p "===== Starting health check for $SERVER on port $PORT ====="

check_ping
check_http
check_disk

echo "Results logged to $LOG_FILE"