#!/bin/bash
# Week 4 – Maintenance & Disk Safety Script

set -euo pipefail

LOG_DIR="/var/log/iot-gateway"
DATA_DIR="data/clean"
DISK_LIMIT=85

echo "[INFO] Maintenance started at $(date)"

# Disk usage check
USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$USAGE" -ge "$DISK_LIMIT" ]; then
  echo "[WARN] Disk usage ${USAGE}% >= ${DISK_LIMIT}%"
  echo "[WARN] Emergency mode enabled"

  # Keep only error logs
  find "$LOG_DIR" -type f ! -name "*error*" -delete
  exit 0
fi

# Cleanup old data (older than 7 days)
find "$DATA_DIR" -type f -mtime +7 -print -delete

echo "[INFO] Maintenance completed successfully"
