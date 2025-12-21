#!/bin/bash
# Week 4 – Maintenance & disk safety

set -euo pipefail

LOG_DIR="/var/log/iot-gateway"
DATA_DIR="/home/ceydahanifed/iot-gateway-minimalist/data/clean"
DISK_LIMIT=85

log() {
  echo "[$(date '+%F %T')] $1" >> "$LOG_DIR/maintenance.log"
}

# === DISK CHECK ===
DISK_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$DISK_USAGE" -ge "$DISK_LIMIT" ]; then
  log "[EMERGENCY] Disk usage ${DISK_USAGE}% - entering emergency mode"

  find "$DATA_DIR" -type f -mtime +7 -delete
  log "[ACTION] Old data files deleted"
else
  log "[OK] Disk usage normal: ${DISK_USAGE}%"
fi
