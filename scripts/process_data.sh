#!/bin/bash
# Week 2 – Text processing & regex based data sanitization

set -euo pipefail

RAW_DATA="data/raw/sensor_data.csv"
CLEAN_DATA="data/clean/sensor_data_clean.csv"

echo "device_id,timestamp,temperature_c,humidity_percent,status" > "$CLEAN_DATA"

sed 's/;/,/g' "$RAW_DATA" \
| grep -Ev '^(#|\*\*\*)' \
| grep -E '^"?IOT-GWAY-[0-9]+' \
| grep -E '^[^,]+,[^,]+,[^,]+,[^,]+,[^,]+' \
| awk -F',' 'BEGIN{OFS=","}
{
  gsub(/"/, "", $0)
  gsub(/^[ \t]+|[ \t]+$/, "", $0)

  temp = $3 + 0
  hum  = $4 + 0
  dev  = $1

  if (dev !~ /^IOT-GWAY-[0-9]+$/) next
  if (temp < 0 || temp > 100) next
  if (hum < 0 || hum > 100) next

  print $1,$2,temp,hum,$5
}' >> "$CLEAN_DATA"

echo "[INFO] Week 2 data sanitization completed."
