#!/bin/bash
# Week 4 – Secure data transfer with retry, backoff & error handling

set -euo pipefail

# === CONFIG ===
REMOTE_USER="operator"
REMOTE_HOST="localhost"
REMOTE_DIR="/tmp/iot-gateway-recv"
SSH_KEY="$HOME/.ssh/iot_gateway_key"
BASE_DIR="/home/ceydahanifed/iot-gateway-minimalist"
DATA_FILE="$BASE_DIR/data/clean/sensor_data_clean.csv"

MAX_RETRY=5
WAIT=2

# === FUNCTIONS ===
log() {
  echo "[$(date '+%F %T')] $1"
}

on_error() {
  log "[ERROR] Unexpected failure occurred"
  exit 1
}

trap on_error ERR

transfer_data() {
  scp -i "$SSH_KEY" -C "$DATA_FILE" \
    "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"
}

# === MAIN ===
attempt=1

while [ $attempt -le $MAX_RETRY ]; do
  log "Transfer attempt $attempt"

  if transfer_data; then
    log "[SUCCESS] Data transfer completed"
    exit 0
  fi

  log "[WARN] Transfer failed, retrying in $WAIT seconds..."
  sleep $WAIT
  WAIT=$((WAIT * 2))
  attempt=$((attempt + 1))
done

log "[ERROR] Transfer failed after $MAX_RETRY attempts"
exit 1

