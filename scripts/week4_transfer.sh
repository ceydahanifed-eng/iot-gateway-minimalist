#!/bin/bash
# Week 4 – Secure data transfer with retry & backoff

set -euo pipefail

REMOTE_USER="operator"
REMOTE_HOST="localhost"
REMOTE_DIR="/tmp/iot-gateway-recv"
SSH_KEY="$HOME/.ssh/iot_gateway_key"
DATA_FILE="data/clean/sensor_data_clean.csv"

MAX_RETRY=5
WAIT=2

attempt=1

while [ $attempt -le $MAX_RETRY ]; do
  echo "[INFO] Transfer attempt $attempt"

  if scp -i "$SSH_KEY" -C "$DATA_FILE" \
     "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"; then
    echo "[SUCCESS] Data transfer completed"
    exit 0
  fi

  echo "[WARN] Transfer failed, retrying in $WAIT seconds..."
  sleep $WAIT
  WAIT=$((WAIT * 2))
  attempt=$((attempt + 1))
done

echo "[ERROR] Transfer failed after $MAX_RETRY attempts"
exit 1
