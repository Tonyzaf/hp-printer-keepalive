#!/usr/bin/env bash

PRINTER_IP="192.168.1.141"
URL="http://${PRINTER_IP}/"
LOGFILE="/var/log/hp-printer-keepalive.log"
INTERVAL=300

while true; do
  TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

  HTTP_CODE="$(curl -sS -m 10 -o /dev/null -w '%{http_code}' "$URL" 2>&1)"
  CURL_EXIT=$?

  if [ "$CURL_EXIT" -eq 0 ]; then
    echo "$TIMESTAMP OK http_code=$HTTP_CODE" >> "$LOGFILE"
  else
    echo "$TIMESTAMP FAIL curl_exit=$CURL_EXIT output=$HTTP_CODE" >> "$LOGFILE"
  fi

  sleep "$INTERVAL"
done
