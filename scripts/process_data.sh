#!/bin/bash
# Hafta 2–3 uyumlu: strict mode, zaman, RSS, RAM disk log

set -euo pipefail

RAW_DATA="data/raw/sensor_data.csv"
CLEAN_DATA="data/clean/sensor_data_clean.csv"

# RAM disk log dizini
LOG_DIR="/var/log/iot-gateway"
LOG_FILE="$LOG_DIR/process.log"

mkdir -p "$LOG_DIR"
exec >> "$LOG_FILE" 2>&1

echo "=== Telemetry processing started at $(date) ==="

# === Süre ölçümü ===
time (
  sed 's/;/,/g' "$RAW_DATA" \
  | grep -E '^[^,]+,[^,]+,[^,]+,[^,]+$' \
  | awk -F',' 'BEGIN{OFS=","}
    NR==1 {print; next}
    {
      t=$3+0; h=$4+0;
      if (t < 0 || t > 100) next;
      if (h < 0 || h > 100) next;
      print
    }' > "$CLEAN_DATA"
)

# === RSS bellek ölçümü ===
echo "=== Resource usage (RSS in KB) ==="
ps -o pid,rss,cmd -p $$

echo "=== Telemetry processing finished at $(date) ==="
