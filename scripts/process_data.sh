#!/bin/bash
# Week 2 – Regex based text processing & data sanitization

set -euo pipefail

RAW_DATA="data/raw/sensor_data.csv"
CLEAN_DATA="data/clean/sensor_data_clean.csv"

# Log configuration
LOG_DIR="/var/log/iot-gateway"
LOG_FILE="$LOG_DIR/process.log"

mkdir -p "$LOG_DIR"

# Redirect all output (stdout + stderr) to log
exec >> "$LOG_FILE" 2>&1

echo "=== Week 2 processing started at $(date) ==="

# CSV header
echo "device_id,timestamp,temperature_c,humidity_percent,status" > "$CLEAN_DATA"

sed 's/;/,/g' "$RAW_DATA" \
| grep -Ev '^(#|\*\*\*)' \
| sed 's/^[[:space:]]*//;s/[[:space:]]*$//' \
| awk -F',' 'BEGIN{OFS=","}
{
  gsub(/"/, "", $0)

  dev  = $1
  temp = $3 + 0
  hum  = $4 + 0

  if (dev !~ /^IOT-GWAY-[0-9]+$/) next
  if (temp < -50 || temp > 100) next
  if (hum < 0 || hum > 100) next

  print dev,$2,temp,hum,$5
}' >> "$CLEAN_DATA"

echo "[INFO] Week 2 data sanitization completed."
echo "=== Finished at $(date) ==="
