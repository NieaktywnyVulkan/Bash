#!/bin/bash
IP=$(hostname -I | awk '{print $1}')
RAM=$(free -m | awk '/Mem:/ {print $2}')
CPU=$(grep -c ^processor /proc/cpuinfo)

STATE_FILE="state.txt"
CURRENT_STATE="$IP|$RAM|$CPU"

if [ ! -f "$STATE_FILE" ]; then
    echo "Pierwsze uruchomienie"

    echo "$CURRENT_STATE" > "$STATE_FILE"

    exit 0
fi

OLD_STATE=$(cat "$STATE_FILE")

if [ "$CURRENT_STATE" != "$OLD_STATE" ]; then
    echo "Zmiana wykryta"

    echo "$CURRENT_STATE" > "$STATE_FILE"

    # Wysyłanie mail
else
    echo "Brak zmian"
fi