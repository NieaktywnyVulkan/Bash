#!/bin/bash

EMAIL="przeszlowskil@gmail.com"

MAIL_CMD=$(command -v mail || command -v mailx)
MSMTP_CMD=$(command -v msmtp)

# 🔹 Sprawdzamy, czy istnieje mail/mailx
if [ -z "$MAIL_CMD" ]; then
    echo "Brak programu mail/mailx"
    echo "Zainstaluj mailutils lub mailx"
    echo "Ubuntu: sudo apt install mailutils"
    echo "Fedora: sudo dnf install mailx"
    exit 1
fi

# 🔹 Sprawdzamy, czy jest msmtp
if [ -z "$MSMTP_CMD" ]; then
    echo "Brak programu msmtp (SMTP)"
    echo "Ubuntu: sudo apt install msmtp msmtp-mta"
    echo "Fedora: sudo dnf install msmtp msmtp-mta"
    exit 1
fi

# 🔹 Sprawdzamy, czy istnieje plik konfiguracyjny
if [ ! -f "$HOME/.msmtprc" ]; then
    echo "Brak pliku konfiguracyjnego ~/.msmtprc"
    echo "Skopiuj szablon z repozytorium i wprowadź swoje hasło aplikacji"
    exit 1
fi

# 🔹 Sprawdzamy uprawnienia pliku
PERM=$(stat -c "%a" "$HOME/.msmtprc")
if [ "$PERM" != "600" ]; then
    echo "Plik ~/.msmtprc musi mieć uprawnienia 600"
    echo "sudo chmod 600 ~/.msmtprc"
    exit 1
fi


send_mail() {
    SUBJECT="$1"
    MESSAGE="$2"

    printf "%s\n" "$MESSAGE" | $MAIL_CMD -s "$SUBJECT" "$EMAIL"
}

IP=$(hostname -I | awk '{print $1}')
RAM=$(free -m | awk '/Mem:/ {print $3}')
CPU=$(grep -c ^processor /proc/cpuinfo)

STATE_FILE="state.txt"
CURRENT_STATE="$IP|$RAM|$CPU"

MESSAGE="Stan systemu:

IP: $IP
RAM: $RAM MB
CPU: $CPU"

if [ ! -f "$STATE_FILE" ]; then
    echo "Pierwsze uruchomienie"

    echo "$CURRENT_STATE" > "$STATE_FILE"

    send_mail "Stan systemu - pierwsze uruchomienie" "$MESSAGE"

    exit 0
fi

OLD_STATE=$(cat "$STATE_FILE")

if [ "$CURRENT_STATE" != "$OLD_STATE" ]; then
    echo "Zmiana wykryta"

    echo "$CURRENT_STATE" > "$STATE_FILE"

    send_mail "Stan systemu - zmiana wykryta" "$MESSAGE"
else
    echo "Brak zmian"
fi